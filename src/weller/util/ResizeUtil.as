/**
 * Created by wellerpeng on 2016/1/15.
 */
package weller.util {

import flash.display.DisplayObject;
import flash.display.Stage;
import flash.events.Event;
import flash.utils.Dictionary;

public class ResizeUtil {
    public static const TOP:String = "TOP";
    public static const CENTER:String = "CENTER";
    public static const BOTTOM:String = "BOTTOM";
    public static const LEFT:String = "LEFT";
    public static const RIGHT:String = "RIGHT";

    private var _list:Dictionary;

    private var _stageWidth:int;
    private var _stageHeight:int;

    private var _stage:Stage;

    public function ResizeUtil() {
        _list = new Dictionary();
    }

    private static var _Instance:ResizeUtil;
    public static function get Instance():ResizeUtil {
        return _Instance ||= new ResizeUtil();
    }

    public function add(dis:DisplayObject, hAlign:String, vAlign:String, listener:DisplayObject = null, offX:int = 0, offY:int = 0):void {
        var data:ResizeData = new ResizeData();
        data.dis = dis;
        data.hAlign = hAlign;
        data.vAlign = vAlign;
        data.listener = listener ? listener : dis;
        data.offX = offX;
        data.offY = offY;

        _list[dis] = data;
        updateByData(data);
    }

    public function updateByDis(dis:DisplayObject):void {
        updateByData(_list[dis]);
    }

    public function remove(dis:DisplayObject):void {
        delete _list[dis];
    }

    public function init(stage:Stage):void {
        _stage = stage;
        _stageWidth = _stage.stageWidth;
        _stageHeight = _stage.stageHeight;
        stage.addEventListener(Event.RESIZE, onResize);
    }

    private function updateByData(data:ResizeData):void {
        if (!data)return;
        switch (data.hAlign) {
            case LEFT:
                data.dis.x = 0;
                break;
            case CENTER:
                data.dis.x = _stageWidth / 2 - data.listener.width / 2;
                break;
            case RIGHT:
                data.dis.x = _stageWidth - data.listener.width;
                break;
        }

        switch (data.vAlign) {
            case TOP:
                data.dis.y = 0;
                break;
            case BOTTOM:
                data.dis.y = _stageHeight - data.listener.height;
                break;
            case CENTER:
                data.dis.y = _stageHeight / 2 - data.listener.height / 2;
        }
        data.dis.x += data.offX;
        data.dis.y += data.offY;
    }

    public function onResize(event:Event):void {
        _stageWidth = _stage.stageWidth;
        _stageHeight = _stage.stageHeight;
        for (var key:* in _list) {
            var data:ResizeData = _list[key];
            updateByData(data);
        }
    }
}
}
