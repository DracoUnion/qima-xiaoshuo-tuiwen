<?php
/**
 * Notes:
 * User: armstrong
 * Date: 2023/8/2
 * Time: 21:04
 * @return
 */

namespace app\task\command;

use AlibabaCloud\Client\AlibabaCloud;
use AlibabaCloud\Client\Exception\ClientException;
use AlibabaCloud\Client\Exception\ServerException;
use app\admin\model\video\Item;
use think\console\Command;
use think\console\Input;
use think\console\Output;
use think\Db;

class Audio extends Command
{
    protected function configure()
    {
        $this->setName('audio')->setDescription('Here is the remark ');
    }

    protected function execute(Input $input, Output $output)
    {
        $output->writeln("芜湖,开始啦！");
        if (config('site.is_windows')) {
            while (true) {
                $this->task();
                sleep(config('site.audio_time'));
            }
        }else{
            $this->task();
        }
    }

    /**
     * Notes:支持阿里云语音合成所有发音人和情感 可自行更换
     * @return false|void
     * @throws ClientException
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    private function task()
    {
        $model = new Item();
        $item = $model->where('audiofile', null)
            ->whereOr('audiofile', '')
            ->order('id', 'asc')
            ->order('id', 'asc')
            ->find();
        if (!$item) {
            echo '暂无任务！'.PHP_EOL;
            return false;
        }
        $fragment = $item['fragment'];
        $emotion = 'story';
        $fragment = '<speak><emotion category="' . $emotion . '" intensity="1.0">' . $fragment . '</emotion></speak>';
        $text = urlencode($fragment);
        $token = $this->getToken();
        $format = 'mp3'; //音频编码格式，支持.pcm、.wav和.mp3格式。默认值：pcm。
        $voice = 'zhimiao_emo';
        $speech_rate = $item['audio_speech_rate'];
        $pitch_rate = $item['audio_pitch_rate'];
        $url = 'https://nls-gateway-cn-shanghai.aliyuncs.com/stream/v1/tts?appkey=' . config('site.appkey') . '&token=' . $token .
            '&text=' . $text . '&format=' . $format . '&sample_rate=16000&voice=' . $voice .
            '&speech_rate=' . $speech_rate . '&pitch_rate=' . $pitch_rate;
        $data = file_get_contents($url);
        $root_path = ROOT_PATH . 'public/';

        $dir = 'tts/' . date("Ymd");
        create_file($root_path . $dir);
        $name = $dir . '/' . time() . '.' . $format;
        file_put_contents($root_path . $name, $data);
        $getID3 = new \getID3();
        $audio_duration = $getID3->analyze($root_path . $name);
        $audio_duration = $audio_duration['playtime_seconds'];
        $audio_duration *= 1000000;
        $model->where('id', $item['id'])->update(['audiofile' => '/' . $name, 'step' => '3', 'audio_duration' => $audio_duration]);
        echo '配音成功--task_id=' . $item['task_id'] . '--item_id=' . $item['id'] .PHP_EOL;
    }

    /**
     * Notes:获取Token 建议使用Redis or Cache 来保存token token有效期很久 好像是2天
     * @return mixed|void
     * @throws ClientException
     */
    private function getToken()
    {
        $AccessToken = '';
        AlibabaCloud::accessKeyClient(
            config('site.access_key_id'),
            config('site.access_key_secret'))
            ->regionId("cn-shanghai")
            ->asDefaultClient();
        try {
            $response = AlibabaCloud::nlsCloudMeta()
                ->v20180518()
                ->createToken()
                ->request();
            $token = $response["Token"];
            if ($token != NULL) {
                $AccessToken = $token["Id"];
            } else {
                echo 'token 获取失败'.PHP_EOL;
                die();
            }
        } catch (ClientException|ServerException $exception) {
            // 获取错误消息
            echo $exception->getErrorMessage().PHP_EOL;
            die();
        }
        return $AccessToken;
    }
}