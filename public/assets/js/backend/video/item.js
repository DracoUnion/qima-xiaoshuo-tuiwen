define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'video/item/index' + location.search,
                    add_url: 'video/item/add',
                    edit_url: 'video/item/edit',
                    del_url: 'video/item/del',
                    multi_url: 'video/item/multi',
                    import_url: 'video/item/import',
                    table: 'video_item',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                sortOrder:'asc',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'task.title', title: __('Task_id'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        // {field: 'task_id', title: __('Task_id')},
                        {field: 'fragment', title: __('Fragment'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'positive_prompt', title: __('Positive_prompt'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {
                            field: 'images', title: __('Images'), operate: false, events: Table.api.events.image,
                            formatter: function (value, row, index) {
                                if (value === '' || value == null) {
                                    return '等待起飞';
                                }
                                const paths = value.split(",");
                                let list = '';
                                for (const path of paths) {
                                    list += '<a href="javascript:" class="btn-select" data-id="' + row.id + '" data-image="' + path + '"><img class="img-sm img-center" src="' + path + '"><i class="fa fa-check"></i></a> ';
                                }
                                return list;
                            }
                        },
                        {field: 'image', title: __('Image'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.images},
                        {field: 'audiofile', title: __('Audiofile'), operate: false, formatter: Table.api.formatter.file},
                        // {field: 'videofile', title: __('Videofile'), operate: false, formatter: Table.api.formatter.file},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'step', title: __('Step'), searchList: {"0":__('Step 0'),"1":__('Step 1'),"2":__('Step 2'),"3":__('Step 3')}, formatter: Table.api.formatter.normal},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });
            //选择图片
            $(document).on("click", ".btn-select", function () {
                var id = $(this).data('id');
                var image = $(this).data('image');
                $.ajax({
                    url: 'video/item/select/ids/'+id,
                    type: 'POST',
                    data:{'image':image},
                    success: function(response) {
                        // 请求成功的处理逻辑
                        Layer.msg(response.msg);
                        table.bootstrapTable('refresh');
                    }
                });
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        recyclebin: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    'dragsort_url': ''
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: 'video/item/recyclebin' + location.search,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {
                            field: 'deletetime',
                            title: __('Deletetime'),
                            operate: 'RANGE',
                            addclass: 'datetimerange',
                            formatter: Table.api.formatter.datetime
                        },
                        {
                            field: 'operate',
                            width: '140px',
                            title: __('Operate'),
                            table: table,
                            events: Table.api.events.operate,
                            buttons: [
                                {
                                    name: 'Restore',
                                    text: __('Restore'),
                                    classname: 'btn btn-xs btn-info btn-ajax btn-restoreit',
                                    icon: 'fa fa-rotate-left',
                                    url: 'video/item/restore',
                                    refresh: true
                                },
                                {
                                    name: 'Destroy',
                                    text: __('Destroy'),
                                    classname: 'btn btn-xs btn-danger btn-ajax btn-destroyit',
                                    icon: 'fa fa-times',
                                    url: 'video/item/destroy',
                                    refresh: true
                                }
                            ],
                            formatter: Table.api.formatter.operate
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },

        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});
