/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 16-1-24
 * Time: 上午12:05
 * To change this template use File | Settings | File Templates.
 */
package weller.util {
import flash.events.Event;
import flash.net.FileFilter;
import flash.net.FileReference;

import weller.game.GameEvent;

import weller.game.event.GameDispatcher;

public class FileReferenceUtil {
    private static var _Instance:FileReferenceUtil;

    public function FileReferenceUtil() {
    }

    public static function get Instance():FileReferenceUtil {
        return _Instance ||= new FileReferenceUtil();
    }

    private var _file:FileReference;
    public function startup(dec:*,filter:*):void
    {
        _file = new FileReference();
        _file.browse(/*[new FileFilter(dec,filter)]*/);
        _file.addEventListener(Event.SELECT,onFileSelect);
    }

    private function onFileSelect(e:Event):void {
        _file.removeEventListener(Event.SELECT,onFileSelect);
        _file.addEventListener(Event.COMPLETE,onLoadComplete);
        _file.load();
    }

    private function onLoadComplete(event:Event):void {
        _file.removeEventListener(Event.COMPLETE,onLoadComplete);
        _file = null;
    }


    public function saveToURL(url:String):void
    {
        _file = new FileReference();
        _file.save(url);
    }

}
}
