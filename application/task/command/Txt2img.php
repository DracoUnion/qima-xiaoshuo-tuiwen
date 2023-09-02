<?php
/**
 * Notes:
 * User: armstrong
 * Date: 2023/8/2
 * Time: 21:29
 * @return
 */

namespace app\task\command;

use app\admin\model\video\Item;
use fast\Http;
use think\console\Command;
use think\console\Input;
use think\console\Output;

class Txt2img extends Command
{
    protected function configure()
    {
        $this->setName('txt2img')->setDescription('Here is the remark ');
    }

    protected function execute(Input $input, Output $output)
    {
        $output->writeln("芜湖,开始啦！");
        if (config('site.is_windows')) {
            while (true) {
                $this->task();
                sleep(config('site.txt2img_time'));
            }
        }else{
            $this->task();
        }
    }

    protected function task()
    {
        $model = new Item();
        $item = $model->where('draw_status', '<>', 1)
            ->where('positive_prompt', '<>', '')
            ->where('images', null)
            ->whereOr('images', '')
            ->order('id', 'asc')
            ->find();
        if (!$item) {
            echo '暂无任务！'.PHP_EOL;
            return false;
        }
        $styles = $item['stylestags'];
        $styles = explode(',', $styles);
        $body = [
            'prompt'          => $item['positive_prompt'],
            'negative_prompt' => $item['negative_prompt'],
            'width'           => $item['width'],
            'height'          => $item['height'],
            "steps"           => $item['steps'],
            'restore_faces'   => $item['restore_faces_switch'],
            'styles'          => $styles,
            'batch_size'      => $item['batch_size'],
            'sampler_name'    => 'DPM++ 2M Karras',
//            'enable_hr'       => true,
//            'hr_scale'        => 1
        ];
        $options = [
            CURLOPT_CONNECTTIMEOUT => 9000,
            CURLOPT_TIMEOUT        => 9000,
            CURLOPT_HTTPHEADER     => ['Content-Type: application/json', 'accept：application/json']
        ];
        $result = Http::sendRequest(config('site.stable_diffusion_url') . '/sdapi/v1/txt2img', json_encode($body), 'POST', $options);
        if ($result['ret']) {
            $msg = json_decode($result['msg'], true);
            $images = $msg['images'];
            if (count($images) === 0) {
                echo '绘图失败'.PHP_EOL;
            }
            $imagesname = '';
            foreach ($images as $value) {
                // 解码Base64字符串为二进制数据
                $binaryImage = base64_decode($value);
                $root_path = ROOT_PATH . 'public/';
                $dir = 'txt2img/' . date("Ymd");
                create_file($root_path . $dir);
                // 生成唯一的文件名
                $filename = $dir . '/' . uniqid() . '.png';
                // 保存图片文件
                file_put_contents($root_path . $filename, $binaryImage);
                $imagesname .= '/' . $filename . ',';
            }
            // 去除最后一个逗号
            $imagesname = rtrim($imagesname, ',');
            $model->where('id', $item['id'])->update(['images' => $imagesname, 'step' => '2','updatetime' => time()]);
            echo '绘图完毕'.PHP_EOL;
        }
    }
}