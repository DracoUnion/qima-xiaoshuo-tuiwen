<?php

namespace app\admin\controller\video;

use app\common\controller\Backend;

/**
 *
 *
 * @icon fa fa-circle-o
 */
class Item extends Backend
{

    /**
     * Item模型对象
     * @var \app\admin\model\video\Item
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\video\Item;
        $this->view->assign("stepList", $this->model->getStepList());
        $this->view->assign("videoAnimationList", $this->model->getVideoAnimationList());
        $this->view->assign("promptModesList", $this->model->getPromptModesList());
    }



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


    /**
     * 查看
     */
    public function index()
    {
        //当前是否为关联查询
        $this->relationSearch = true;
        //设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $subwhere = [];
            if (input('task_id')) {
                $subwhere = ['task_id' => input('task_id')];
            }
            $list = $this->model
                ->with(['task', 'category'])
                ->where($where)
                ->where($subwhere)
                ->order($sort, $order)
                ->paginate($limit);

            foreach ($list as $row) {

                $row->getRelation('task')->visible(['title']);
                $row->getRelation('category')->visible(['nickname']);
            }

            $result = array("total" => $list->total(), "rows" => $list->items());

            return json($result);
        }
        return $this->view->fetch();
    }

    public function select($ids = null)
    {
        $row = $this->model->get($ids);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $adminIds = $this->getDataLimitAdminIds();
        if (is_array($adminIds) && !in_array($row[$this->dataLimitField], $adminIds)) {
            $this->error(__('You have no permission'));
        }
        $data = [
            'image' => input('image'),
        ];
        $result = $row->allowField(true)->save($data);
        if ($result) {
            $this->success('选中成功!');
        }
        $this->error('选中失败!');
    }

}
