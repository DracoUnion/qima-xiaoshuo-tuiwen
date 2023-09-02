define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'video/tagger/index' + location.search,
                    add_url: 'video/tagger/add',
                    edit_url: 'video/tagger/edit',
                    del_url: 'video/tagger/del',
                    multi_url: 'video/tagger/multi',
                    import_url: 'video/tagger/import',
                    table: 'video_item',
                }
            });

            Controller.api.bindevent();
        },

        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {

                Form.api.bindevent($("form[role=form]"), function(data, ret){
                    //如果我们需要在提交表单成功后做跳转，可以在此使用location.href="链接";进行跳转
                    $("#c-prompt").val(data);
                    return false;
                }, function(data, ret){
                    Toastr.success("失败");
                }, function(success, error){
                    //bindevent的第四个参数为提交前的回调
                    //如果我们需要在表单提交前做一些数据处理，则可以在此方法处理
                    //注意如果我们需要阻止表单，可以在此使用return false;即可
                    //如果我们处理完成需要再次提交表单则可以使用submit提交,如下
                    Form.api.submit(this, success, error);
                    // return false;
                });
            }
        }
    };
    return Controller;
});
