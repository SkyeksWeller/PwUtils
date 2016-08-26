/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 16-1-23
 * Time: 下午1:39
 * To change this template use File | Settings | File Templates.
 */
package weller.util {
import flash.display.DisplayObject;
import flash.filters.ColorMatrixFilter;

public class DisplayUtil {
    private static var _ColorMatrixFilter:ColorMatrixFilter;
    public function DisplayUtil() {
    }


    public static function Disable(displayObject:DisplayObject):void
    {
        displayObject.filters = [GetGrayFilter()];
        if(displayObject.hasOwnProperty("mouseEnabled"))displayObject["mouseEnabled"] = false;
    }

    public static function Enable(displayObject:DisplayObject):void
    {
        displayObject.filters = null;
        if(displayObject.hasOwnProperty("mouseEnabled"))displayObject["mouseEnabled"] = true;
    }

    private static function GetGrayFilter():ColorMatrixFilter
    {
        if(!_ColorMatrixFilter)
        {
            var arr:Array = [0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0];
            _ColorMatrixFilter = new ColorMatrixFilter(arr);
        }
        return _ColorMatrixFilter;;
    }
}
}
