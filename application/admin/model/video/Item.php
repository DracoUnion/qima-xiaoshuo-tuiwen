<?php

namespace app\admin\model\video;

use think\Model;
use traits\model\SoftDelete;

class Item extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'video_item';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'step_text',
        'video_animation_text',
        'prompt_modes_text'
    ];
    

    protected static function init()
    {
        self::afterInsert(function ($row) {
            $pk = $row->getPk();
            $row->getQuery()->where($pk, $row[$pk])->update(['weigh' => $row[$pk]]);
        });
    }

    
    public function getStepList()
    {
        return ['0' => __('Step 0'), '1' => __('Step 1'), '2' => __('Step 2'), '3' => __('Step 3')];
    }

    public function getVideoAnimationList()
    {
        return ['-2' => __('Video_animation -2'),'-1' => __('Video_animation -1'), '0' => __('Video_animation 0'), '1' => __('Video_animation 1'), '2' => __('Video_animation 2'), '3' => __('Video_animation 3')];
    }

    public function getPromptModesList()
    {
        return ['0' => __('Prompt_modes 0'), '1' => __('Prompt_modes 1')];
    }


    public function getStepTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['step']) ? $data['step'] : '');
        $list = $this->getStepList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getVideoAnimationTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['video_animation']) ? $data['video_animation'] : '');
        $list = $this->getVideoAnimationList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getPromptModesTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['prompt_modes']) ? $data['prompt_modes'] : '');
        $list = $this->getPromptModesList();
        return isset($list[$value]) ? $list[$value] : '';
    }




    public function task()
    {
        return $this->belongsTo('Task', 'task_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }


    public function category()
    {
        return $this->belongsTo('app\admin\model\Category', 'audio_voice_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }
}
