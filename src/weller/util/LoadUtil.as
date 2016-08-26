/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 16-1-27
 * Time: 下午11:18
 * To change this template use File | Settings | File Templates.
 */
package weller.util {
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

import weller.game.GameEvent;

import weller.game.event.GameDispatcher;

public class LoadUtil {
    private static var _Instance:LoadUtil;

    public static function get Instance():LoadUtil
    {
        return _Instance||=new LoadUtil();
    }
    public function LoadUtil() {
    }

    private var _urlLoader:URLLoader;

    public function load(url:String):void
    {
        _urlLoader = new URLLoader();
        var request:URLRequest = new URLRequest(url);
        _urlLoader.addEventListener(Event.COMPLETE,onComplete);
        _urlLoader.load(request);
    }

    private function onComplete(event:Event):void {
        _urlLoader.removeEventListener(Event.COMPLETE,onComplete);
    }
}
}
