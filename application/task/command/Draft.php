<?php
/**
 * Notes:
 * User: armstrong
 * Date: 2023/8/2
 * Time: 22:01
 * @return
 */

namespace app\task\command;

use think\console\Command;
use think\console\Input;
use think\console\Output;
use think\Db;

use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;
use ZipArchive;

class Draft extends Command
{
    protected $draft_removable_storage_device = 'D:';
    protected $draft_root_path = 'D:/JianyingPro Drafts/';
    protected $draft_cover = 'draft_cover.jpg';


    protected $item = [];
    protected function configure()
    {
        $this->setName('draft')->setDescription('Here is the remark ');
    }

    protected function execute(Input $input, Output $output)
    {
        $output->writeln("芜湖,开始啦！");
        if (config('site.is_windows')) {
            while (true) {
                $this->task();
                sleep(config('site.draft_time'));
            }
        }else{
            $this->task();
        }
    }

    private function task(){
        $this->item = Db::name('video_item')
            ->alias('i')
            ->join('video_task t', 'i.task_id = t.id')
            ->where('t.status', '2')
            ->field('i.*,t.title as task_name')
            ->order('id', 'asc')
            ->select();
        if (!$this->item) {
            echo '暂无任务！'.PHP_EOL;
            return false;
        }
        foreach ($this->item as $value) {
            if (empty($value['image'])) {
                $this->task_update($value['task_id']);
                echo '生成失败,请检查ID：' . $value['id'] . '项目图片是否选择'.PHP_EOL;
                return false;
            }
            if (empty($value['audiofile'])) {
                $this->task_update($value['task_id']);
                echo '生成失败,请检查ID：' . $value['id'] . '项目配音是否已生成'.PHP_EOL;
                return false;
            }
        }
        $this->draft_removable_storage_device = config('site.draft_removable_storage_device');
        $this->draft_root_path = config('site.draft_root_path');
        if (empty($this->draft_removable_storage_device)||empty($this->draft_root_path)){
            $this->task_update($this->item[0]['task_id']);
            echo '请检查配置文件'.PHP_EOL;
            return false;
        }
        $this->draft_meta_info();
    }

    /**
     * Notes:需要生成关键帧 可以自行添加
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    private function draft_meta_info()
    {
        /*  meta_info   */
        $save_path = $this->item[0]['task_id'] . '_' . $this->item[0]['task_name'];
        $draft_json = config('site.draft_meta_info');
        $draft = json_decode($draft_json, true);
        $draft['draft_name'] = $this->item[0]['task_name'];
        $draft['draft_removable_storage_device'] = $this->draft_removable_storage_device;
        $draft['draft_root_path'] = $this->draft_root_path;
        $draft['draft_cover'] = $this->draft_cover;
        $draft['draft_id'] = \fast\Random::uuid();
        $draft['draft_fold_path'] = $this->draft_root_path . '/' . $draft['draft_name'];
        copy_file($this->item[0]['image'], 'draft/' . $save_path . '/', 'draft_cover.jpg');
        /*  meta_info结束   */
        /*  content   */
        $draft_content_json = config('site.draft_content');
        $draft_content = json_decode($draft_content_json, true);
        $draft_content['id'] = \fast\Random::uuid();
        $audios = [];
        $beats = [];
        $canvases = [];
        $sound_channel_mappings = [];
        $speeds = [];
        $videos = [];
        $tracks[] = template_tracks();
        $tracks[] = template_tracks();
        $tracks[0]['type'] = 'video';
        $tracks[1]['type'] = 'audio';
        $draft_content['tracks'] = $tracks;
        $segments_video = [];
        $segments_audio = [];
        $start = 0;
        foreach ($this->item as $key => $value) {
            /*  meta_info   */
            // 片段时长
            $duration = (int)$value['audio_duration'];
            /*  图片操作    */
            $image_value = template_materials();
            copy_file($value['image'], 'draft/' . $save_path . '/image/', $key . '.jpg');
            $image_value['duration'] = $duration;
            $image_value['extra_info'] = $key . '.jpg';
            $image_value['file_Path'] = $this->draft_root_path . $save_path . '/image/' . $key . '.jpg';
            $image_value['roughcut_time_range']['duration'] = $duration;
            $image_value['metetype'] = 'photo';
            /* 音频操作 */
            $audio_value = template_materials();
            copy_file($value['audiofile'], 'draft/' . $save_path . '/audio/', $key . '.mp3');
            $audio_value['duration'] = $duration;
            $audio_value['extra_info'] = $key . '.mp3';
            $audio_value['file_Path'] = $this->draft_root_path . $save_path . '/audio/' . $key . '.mp3';
            $audio_value['roughcut_time_range']['duration'] = $duration;
            $audio_value['metetype'] = 'music';
            /* 添加素材 */
            $draft['draft_materials'][0]['value'][] = $image_value;
            $draft['draft_materials'][0]['value'][] = $audio_value;
            /*  content   */
            //  materials['audios']     PS:audios['id']需要使用
            $audios_template = template_audios();
            $audios_template['local_material_id'] = $audio_value['id'];// meat_info.json中的素材ID
            $audios_template['name'] = $audio_value['extra_info'];
            $audios_template['path'] = $audio_value['file_Path'];
            $audios[] = $audios_template;
            //  materials['beats']      PS:beats['id']需要使用
            $beats_template = template_beats();
            $beats[] = $beats_template;
            //  materials['canvases']   PS:canvases['id']需要使用
            $canvases_template = template_canvases();
            $canvases[] = $canvases_template;
            //  materials['sound_channel_mappings'] 双份   PS:sound_channel_mappings['id']需要使用

            $sound_channel_mappings[] = template_sound_channel_mappings();
            $sound_channel_mappings[] = template_sound_channel_mappings();
            //  materials['speeds'] 双份   PS:speeds['id']需要使用
            $speeds[] = template_speeds();
            $speeds[] = template_speeds();
            //  materials['videos']   PS:videos['id']需要使用
            $videos_template = template_videos();
            $videos_template['duration'] = $duration;
            $videos_template['material_name'] = $image_value['extra_info'];
            $videos_template['path'] = $image_value['file_Path'];
            $videos_template['type'] = 'photo';
            $videos_template['width'] = 512;
            $videos_template['height'] = 512;
            $videos[] = $videos_template;
            //  tracks
            $segments_video_template = template_segments();
            $segments_video_template['extra_material_refs'] = [
                $speeds[$key]['id'],
                $canvases_template['id'],
                $sound_channel_mappings[$key]['id']
            ];
            $segments_video_template['material_id'] = $videos_template['id'];
            $segments_video_template['source_timerange']['duration'] = $duration;
            $segments_video_template['target_timerange']['duration'] = $duration;
            $segments_video_template['target_timerange']['start'] = $start;
//            $segments_video[] = $segments_video_template;
            //关键帧
            $segments_video[] = $this->keyframes_random($segments_video_template,$value['video_animation']);
            $segments_audio_template = template_segments();
            $segments_audio_template['extra_material_refs'] = [
                $speeds[$key + 1]['id'],
                $beats_template['id'],
                $sound_channel_mappings[$key + 1]['id']
            ];
            $segments_audio_template['material_id'] = $audios_template['id'];
            $segments_audio_template['source_timerange']['duration'] = $duration;
            $segments_audio_template['target_timerange']['duration'] = $duration;
            $segments_audio_template['target_timerange']['start'] = $start;
            $segments_audio[] = $segments_audio_template;
            $start += $duration;
        }
        $draft_content['duration'] = $start;
        $draft_content['materials']['audios'] = $audios;
        $draft_content['materials']['beats'] = $beats;
        $draft_content['materials']['canvases'] = $canvases;
        $draft_content['materials']['sound_channel_mappings'] = $sound_channel_mappings;
        $draft_content['materials']['speeds'] = $speeds;
        $draft_content['materials']['videos'] = $videos;
        $draft_content['tracks'][0]['segments'] = $segments_video;
        $draft_content['tracks'][1]['segments'] = $segments_audio;

        $draft_meta_info = json_encode($draft, JSON_UNESCAPED_UNICODE);
        file_put_contents(ROOT_PATH . 'public/'.'draft/' . $save_path . '/draft_meta_info.json', $draft_meta_info);
        $draft_content = json_encode($draft_content, JSON_UNESCAPED_UNICODE);
        file_put_contents(ROOT_PATH . 'public/'.'draft/' . $save_path . '/draft_content.json', $draft_content);
        $this->make_zip_file_for_folder(ROOT_PATH . 'public/'.'draft/' . $save_path . '.zip', ROOT_PATH . 'public/'.'draft/' . $save_path);
        Db::name('video_task')
            ->where('id', $this->item[0]['task_id'])
            ->update(['draftfile' => '/draft/' . $save_path . '.zip', 'updatetime' => time(), 'status' => '3']);
        echo '导出草稿成功'.PHP_EOL;
    }

    private function make_zip_file_for_folder($zip_path = '', $folder_path = '')
    {
        // Get real path for our folder
        $rootPath = realpath($folder_path);
        // Initialize archive object
        $zip = new \ZipArchive();
        $zip->open($zip_path, ZipArchive::CREATE | ZipArchive::OVERWRITE);

        // Create recursive directory iterator
        $files = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($rootPath),
            RecursiveIteratorIterator::LEAVES_ONLY
        );

        foreach ($files as $name => $file) {
            // Skip directories (they would be added automatically)
            if (!$file->isDir()) {
                // Get real and relative path for current file
                $filePath = $file->getRealPath();
                $relativePath = substr($filePath, strlen($rootPath) + 1);

                // Add current file to archive
                $zip->addFile($filePath, $relativePath);
            }
        }
        $zip->close();
    }

    private function task_update($id){
        Db::name('video_task')->where('id',$id)->update(['status'=>'0']);
    }

    private function keyframes_large_to_small($segments)
    {
        $common_keyframes[] = template_common_keyframes();
        $keyframe_list = [];
        $keyframe_start = template_keyframe_list();
        $duration = $segments['target_timerange']['duration'];
        $values = round($duration / 10000000, 2) + 1.0;
        $keyframe_start['values'][] = $values;

        $keyframe_list[] = $keyframe_start;
        $keyframe_end = template_keyframe_list();
        $keyframe_end['time_offset'] = $segments['target_timerange']['duration'];
        $keyframe_end['values'][] = 1.0;
        $keyframe_list[] = $keyframe_end;
        $common_keyframes[0]['keyframe_list'] = $keyframe_list;
        $segments['common_keyframes'] = $common_keyframes;
        return $segments;
    }

    private function keyframes_small_to_large($segments)
    {
        $common_keyframes[] = template_common_keyframes();
        $keyframe_list = [];
        $keyframe_start = template_keyframe_list();
        $duration = $segments['target_timerange']['duration'];
        $values = round($duration / 10000000, 2) + 1.0;
        $keyframe_start['values'][] = 1.0;
        $keyframe_list[] = $keyframe_start;
        $keyframe_end = template_keyframe_list();
        $keyframe_end['time_offset'] = $segments['target_timerange']['duration'];
        $keyframe_end['values'][] = $values;
        $keyframe_list[] = $keyframe_end;
        $common_keyframes[0]['keyframe_list'] = $keyframe_list;
        $segments['common_keyframes'] = $common_keyframes;
        return $segments;
    }

    private function keyframes_top_to_bottom($segments)
    {
        $duration = $segments['target_timerange']['duration'];
        $scale = round($duration / 10000000, 2) + 1.0;
        $segments['clip']['scale']['x'] = $scale;
        $segments['clip']['scale']['y'] = $scale;
        $transform = round($duration / 10000000, 2) / 2;
        $segments['clip']['transform']['y'] = $transform;

        $list1 = template_common_keyframes_all();
        $list1['keyframe_list'][1]['time_offset'] = $duration;

        $list2 = template_common_keyframes_all();
        $list2['keyframe_list'][0]['values'] = [-$transform];
        $list2['keyframe_list'][1]['time_offset'] = $duration;
        $list2['property_type'] = 'KFTypePositionY';

        $segments['common_keyframes'] = [$list1, $list2];
        return $segments;
    }

    private function keyframes_bottom_to_top($segments)
    {
        $duration = $segments['target_timerange']['duration'];
        $scale = round($duration / 10000000, 2) + 1.0;
        $segments['clip']['scale']['x'] = $scale;
        $segments['clip']['scale']['y'] = $scale;
        $transform = round($duration / 10000000, 2) / 2;
//        $segments['clip']['transform']['y'] = $transform;

        $list1 = template_common_keyframes_all();
        $list1['keyframe_list'][1]['time_offset'] = $duration;

        $list2 = template_common_keyframes_all();
        $list2['keyframe_list'][0]['values'] = [$transform];
        $list2['keyframe_list'][1]['time_offset'] = $duration;
        $list2['property_type'] = 'KFTypePositionY';

        $segments['common_keyframes'] = [$list1, $list2];
        return $segments;
    }

    private function keyframes_left_to_right($segments)
    {
        $duration = $segments['target_timerange']['duration'];
        $scale = round($duration / 10000000, 2) + 1.0;
        $segments['clip']['scale']['x'] = $scale;
        $segments['clip']['scale']['y'] = $scale;
        $transform = round($duration / 10000000, 2) / 2;
//        $segments['clip']['transform']['x'] = -$transform;

        $list1 = template_common_keyframes_all();
        $list1['keyframe_list'][0]['values'] = [$transform];
        $list1['keyframe_list'][1]['time_offset'] = $duration;

        $list2 = template_common_keyframes_all();
        $list2['keyframe_list'][1]['time_offset'] = $duration;
        $list2['property_type'] = 'KFTypePositionY';

        $segments['common_keyframes'] = [$list1, $list2];
        return $segments;
    }

    private function keyframes_right_to_left($segments)
    {
        $duration = $segments['target_timerange']['duration'];
        $scale = round($duration / 10000000, 2) + 1.0;
        $segments['clip']['scale']['x'] = $scale;
        $segments['clip']['scale']['y'] = $scale;
        $transform = round($duration / 10000000, 2) / 2;
//        $segments['clip']['transform']['x'] = -$transform;

        $list1 = template_common_keyframes_all();
        $list1['keyframe_list'][0]['values'] = [-$transform];
        $list1['keyframe_list'][1]['time_offset'] = $duration;

        $list2 = template_common_keyframes_all();
        $list2['keyframe_list'][1]['time_offset'] = $duration;
        $list2['property_type'] = 'KFTypePositionY';

        $segments['common_keyframes'] = [$list1, $list2];
        return $segments;
    }

    private function keyframes_random($segments, $type = '-1')
    {
        if ($type === '-1') {
            $type = rand(0, 5);
        }
        switch ($type) {
            case '-2':
                return $segments;
            case '0':
                return $this->keyframes_large_to_small($segments);
            case '1':
                return $this->keyframes_small_to_large($segments);
            case '2':
                return $this->keyframes_top_to_bottom($segments);
            case '3':
                return $this->keyframes_bottom_to_top($segments);
            case '4':
                return $this->keyframes_left_to_right($segments);
            case '5':
                return $this->keyframes_right_to_left($segments);
        }
    }
}