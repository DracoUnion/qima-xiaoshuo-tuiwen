<?php

namespace app\admin\controller\video;

use app\common\controller\Backend;
use think\Db;
use think\exception\PDOException;
use think\exception\ValidateException;

/**
 *
 *
 * @icon fa fa-circle-o
 */
class Task extends Backend
{

    /**
     * Task模型对象
     * @var \app\admin\model\video\Task
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\video\Task;
        $this->view->assign("modesList", $this->model->getModesList());
        $this->view->assign("promptModesList", $this->model->getPromptModesList());
        $this->view->assign("statusList", $this->model->getStatusList());
        $this->view->assign("videoAnimationList", $this->model->getVideoAnimationList());
    }



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


    /**
     * 添加
     *
     * @return string
     * @throws \think\Exception
     */
    public function add()
    {
        if (false === $this->request->isPost()) {
            return $this->view->fetch();
        }
        $params = $this->request->post('row/a');
        if (empty($params)) {
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $params = $this->preExcludeFields($params);

        if ($this->dataLimit && $this->dataLimitFieldAutoFill) {
            $params[$this->dataLimitField] = $this->auth->id;
        }
        $result = false;
        Db::startTrans();
        try {
            //是否采用模型验证
            if ($this->modelValidate) {
                $name = str_replace("\\model\\", "\\validate\\", get_class($this->model));
                $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.add' : $name) : $this->modelValidate;
                $this->model->validateFailException()->validate($validate);
            }
            $data['title'] = $params['title'];
            $data['content'] = $params['content'];
            $data['prompt_modes'] = $params['prompt_modes'];
            $data['createtime'] = time();
            $data['updatetime'] = time();
            $result = $this->model->allowField(true)->insertGetId($data);
            $task = explode(PHP_EOL, $params['content']);
            // 这里可以自定预设一些参数
            foreach ($task as $value) {
                $value = trim($value);
                if (!empty($value)) {
                    $item [] = [
                        'task_id'                 => $result,
                        'fragment'                => $value,
                        'lorajson'                   => $params['lorajson'],
                        'steps'                   => $params['steps'],
                        'width'                   => $params['width'],
                        'height'                  => $params['height'],
                        'batch_size'              => $params['batch_size'],
                        'restore_faces_switch'    => $params['restore_faces_switch'],
                        'audio_voice_id'          => $params['audio_voice_id'],
                        'audio_emotion_id'        => $params['audio_emotion_id'],
                        'video_animation'         => $params['video_animation'],
                        'prompt_modes'            => $params['prompt_modes'],
                        'audio_volume'            => $params['audio_volume'],
                        'audio_speech_rate'       => $params['audio_speech_rate'],
                        'audio_pitch_rate'        => $params['audio_pitch_rate'],
                        'default_positive_prompt' => config('site.default_positive_prompt'),
                        'default_negative_prompt' => config('site.default_negative_prompt')
                    ];
                }
            }
            $itemModel = new \app\admin\model\video\Item();
            $res = $itemModel->saveAll($item);
            Db::commit();
        } catch (ValidateException|PDOException|Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        if ($result === false) {
            $this->error(__('No rows were inserted'));
        }
        $this->success();
    }


}
