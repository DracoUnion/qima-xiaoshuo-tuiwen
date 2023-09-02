<?php
/**
 * Notes:
 * User: armstrong
 * Date: 2023/8/2
 * Time: 20:47
 * @return
 */

namespace app\task\command;
use app\admin\model\video\Item;
use fast\Http;
use think\console\Command;
use think\console\Input;
use think\console\Output;

class Prompt  extends Command
{
    protected $model = null;
    protected $item = [];
    protected function configure()
    {
        $this->setName('prompt')->setDescription('Here is the remark ');
    }

    protected function execute(Input $input, Output $output)
    {
        $output->writeln("芜湖,开始啦！");
        if (config('site.is_windows')) {
            while (true) {
                $this->task();
                sleep(config('site.prompt_time'));
            }
        }else{
            $this->task();
        }
    }

    private function task(){
        $this->model = new Item();
        $this->item = $this->model
            ->where('positive_prompt', null)
            ->whereOr('positive_prompt', '')
            ->order('id', 'asc')
            ->find();
        if (!$this->item) {
            echo '暂无任务！'.PHP_EOL;
            return false;
        }
        $prompt_modes = $this->item['prompt_modes'];
        switch ($prompt_modes){
            case '0':
                $this->modes_0();
                break;
            case '1':
                $this->modes_1();
                break;
            case '2':
                $this->modes_0();
                break;
        }
    }

    /**
     * Notes:这里只有modes一个 需要更多可以直接在这里添加
     * @return bool
     */
    private function modes_0()
    {
        $prompt = '将以下内容翻译为英文，不要引号：';
        $msg[] = [
            'role'    => 'user',
            'content' => $prompt . $this->item['fragment']
        ];
        $res = chatgpt($msg);
        $json_array = json_decode($res['msg'], true);
        if (isset($json_array['choices'][0]['message']['content'])) {
            $text = str_replace("\\n", "\n", $json_array['choices'][0]['message']['content']);
            $text = str_replace(".", ",", $text);
            $text = str_replace("\"", "", $text);
            $text = $this->lora($text);
            $this->model->where('id', $this->item['id'])->update(['positive_prompt' => $text, 'negative_prompt' => $this->item['default_negative_prompt'], 'step' => '1']);
            echo '提示词执行成功：item_id='.$this->item['id'].PHP_EOL;
            return true;
        }
        $this->model->where('id', $this->item['id'])->update(['step' => '1']);
        echo '提示词执行失败：item_id='.$this->item['id'].PHP_EOL;
        return false;
    }

    private function modes_1()
    {
        $prompt = $this->item['fragment'];
        $data = [
            'text'=>$prompt
        ];
        $options = [
            CURLOPT_CONNECTTIMEOUT => 60,
            CURLOPT_TIMEOUT        => 60,
            CURLOPT_HTTPHEADER     => ['Content-Type: application/json', 'Authorization: Bearer ' . config('site.qima_key')]
        ];
        $res = Http::post('http://gpt.s770.cn/v1/chat/prompt',json_encode($data),$options);
        $json_array = json_decode($res, true);
        if ($json_array['code']!=1){
            $this->model->where('id', $this->item['id'])->update(['step' => '1']);
            echo '提示词执行失败：item_id='.$this->item['id'].$json_array['msg'].PHP_EOL;
            return false;
        }
        $text = $json_array['data'];
        $text = $this->lora($text);
        $this->model->where('id', $this->item['id'])->update(['positive_prompt' => $text, 'negative_prompt' => $this->item['default_negative_prompt'], 'step' => '1']);
        echo '提示词执行成功：item_id='.$this->item['id'].PHP_EOL;
        return true;
    }


    private function lora($positive_prompt)
    {
        $positive_prompt = $this->item['default_positive_prompt'].$positive_prompt;
        // 没有定义lora则直接返回提示词
        if ($this->item['lorajson']) {
            // 解析lora数组
            $lora = json_decode($this->item['lorajson'], true);
            // 片段内容
            $fragment = $this->item['fragment'];
            foreach ($lora as $key => $value) {
                if (strstr($fragment, $key)) {
                    if (!strstr($fragment, $value)) {
                        $positive_prompt = $value.$positive_prompt;
                    }

                }
            }
        }
        return $positive_prompt;
    }
}