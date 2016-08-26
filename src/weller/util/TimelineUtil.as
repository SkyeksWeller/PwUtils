/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 16-1-19
 * Time: 上午12:22
 * To change this template use File | Settings | File Templates.
 */
package weller.util {
import com.greensock.TimelineMax;

import flash.events.Event;
import flash.utils.Dictionary;

public class TimelineUtil {


    public function TimelineUtil() {
    }

    private static var _CallBacks:Dictionary = new Dictionary();

    public static function Bind(tweens:Array, callback:Function):void {
        var timelineMax:TimelineMax = new TimelineMax();
        while (tweens.length)timelineMax.append(tweens.shift());
        _CallBacks[timelineMax] = callback;
        timelineMax.addEventListener(Event.COMPLETE, onComplete);
    }

    private static function onComplete(e:Event):void {
        var timelineMax:TimelineMax = e.target as TimelineMax;
        timelineMax.removeEventListener(Event.COMPLETE, onComplete);
        var callback:Function = _CallBacks[timelineMax];
        if (callback)callback();
        delete _CallBacks[timelineMax];
    }

}
}
