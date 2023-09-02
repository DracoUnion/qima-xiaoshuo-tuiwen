<?php
/**
 * Notes:
 * User: armstrong
 * Date: 2023/8/5
 * Time: 9:11
 * @return
 */

namespace app\admin\controller\video;

use app\common\controller\Backend;
use fast\Http;

class Tagger extends Backend
{

    public function index()
    {
        if (false === $this->request->isPost()) {
            return $this->view->fetch();
        }
        $params = $this->request->post('row/a');
        if (empty($params)) {
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $params = $this->preExcludeFields($params);
        $image = ltrim($params['image'], '/');
        $options = [
            CURLOPT_CONNECTTIMEOUT => 9000,
            CURLOPT_TIMEOUT        => 9000,
            CURLOPT_HTTPHEADER     => ['Content-Type: application/json', 'accept：application/json']
        ];
        // 读取图片文件内容
        $imageData = file_get_contents($image);

        // 将图片内容进行Base64编码
        $base64Image = base64_encode($imageData);
        $data = [
            'image'=>$base64Image,
            'model'=>'wd14-vit-v2-git',
            'threshold'=>0.35
        ];
        $res = Http::post('http://192.168.1.6:7860/tagger/v1/interrogate',json_encode($data),$options);
        $result = json_decode($res,true);
        // 遍历数组并提取键值对
        $p = '';
        foreach ($result["caption"] as $key => $value) {
            $p .=$key.',';

        }
        $this->success('反推成功','',$p);
    }
}