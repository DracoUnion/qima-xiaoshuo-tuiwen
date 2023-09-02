<?php

namespace app\admin\model\video;

use think\Model;
use traits\model\SoftDelete;

class Task extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'video_task';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'modes_text',
        'prompt_modes_text',
        'status_text'
    ];
    

    protected static function init()
    {
        self::afterInsert(function ($row) {
            $pk = $row->getPk();
            $row->getQuery()->where($pk, $row[$pk])->update(['weigh' => $row[$pk]]);
        });
    }

    
    public function getModesList()
    {
        return ['0' => __('Modes 0'), '1' => __('Modes 1')];
    }

    public function getPromptModesList()
    {
        return ['0' => __('Prompt_modes 0'), '1' => __('Prompt_modes 1')];
    }

    public function getStatusList()
    {
        return ['0' => __('Status 0'), '1' => __('Status 1'), '2' => __('Status 2'), '3' => __('Status 3'), '4' => __('Status 4')];
    }

    public function getVideoAnimationList()
    {
        return ['-2' => __('Video_animation -2'),'-1' => __('Video_animation -1'), '0' => __('Video_animation 0'), '1' => __('Video_animation 1'), '2' => __('Video_animation 2'), '3' => __('Video_animation 3')];
    }


    public function getModesTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['modes']) ? $data['modes'] : '');
        $list = $this->getModesList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getPromptModesTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['prompt_modes']) ? $data['prompt_modes'] : '');
        $list = $this->getPromptModesList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }




}
