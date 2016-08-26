/**
 * Created with IntelliJ IDEA.
 * User: pengwei
 * Date: 15-3-10
 * Time: 下午1:12
 * To change this template use File | Settings | File Templates.
 */
package weller.util {
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.utils.Dictionary;

public class PwDebugKeyboard {

   private static var _sStage:Stage;
   private static var _sKeyDic:Dictionary;
   private static var _sParam:String="";

    public static function get stage():Stage
    {
        return _sStage;
    }
   public static function initStage(stage:Stage):void
   {
       clear();
       _sStage = stage;
       _sKeyDic = new Dictionary();
       _sStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
   }

    private static var _sAdjustInfo:Object;
    public static function setUpDownAdjust(obj:Object,prop:String,max:Number,min:Number,adj:Number,keyUp:uint=Keyboard.UP,keyDown:int = Keyboard.DOWN):void
    {
        _sAdjustInfo = {
            obj:obj,
            prop:prop,
            max:max,
            min:min,
            adj:adj
        }
        append(keyUp,UpHandler);
        append(keyDown,DownHandler);
    }

    private static function UpHandler():void
    {
        if(_sAdjustInfo.obj[_sAdjustInfo.prop]<_sAdjustInfo.max)
            _sAdjustInfo.obj[_sAdjustInfo.prop]+=_sAdjustInfo.adj;
    }

    private static function DownHandler():void
    {
        if(_sAdjustInfo.obj[_sAdjustInfo.prop]>_sAdjustInfo.min)
            _sAdjustInfo.obj[_sAdjustInfo.prop]-=_sAdjustInfo.adj;
    }

   public static function append(keyCode:int,callback:Function,isCtrl:Boolean = false,isShift:Boolean = false,isAlt:Boolean = false):String
   {
       var str:String = keyCode.toString();
       (isCtrl)&&(str+="ctrl");
       (isShift)&&(str+="shift");
       (isAlt)&&(str+="alt");
       _sKeyDic[str] = callback;
       return str;
   }

    public static function appendNumCtrl(callback:Function,isCtrl:Boolean = false,isShift:Boolean = false,isAlt:Boolean = false):Array
    {
        var returnArr:Array = [];
       for(var i:int = 48;i<=57;i++)
       {
           var str:String = i.toString();
           (isCtrl)&&(str+="ctrl");
           (isShift)&&(str+="shift");
           (isAlt)&&(str+="alt");
           _sKeyDic[str] = callback;
           returnArr.push(str);
       }

        return returnArr;
    }

    public static function remove(key:String):void
    {
        delete _sKeyDic[key];
    }

    private static function onKeyDownHandler(event:KeyboardEvent):void {
        if(event.keyCode == Keyboard.ENTER||event.keyCode == Keyboard.NUMPAD_ENTER)
        {
            _sParam = "";
        }else if(event.keyCode>=48 && event.keyCode<=57)
        {
            _sParam+=(event.keyCode - 48).toString();
        }

        var str:String = event.keyCode.toString();
        (event.ctrlKey)&&(str+="ctrl");
        (event.shiftKey)&&(str+="shift");
        (event.altKey)&&(str+="alt");
//        try{
            if(_sKeyDic[str]!=null){
                if(_sParam && _sParam.length){
                    _sKeyDic[str].apply(null,[_sParam]);
                    _sParam = "";
                }else{
                    _sKeyDic[str].apply(null);
                }
            }
//        }catch(e:Error)
//        {
//
//        }
    }

    private static function clear():void
    {
        if(_sStage && _sStage.hasEventListener(KeyboardEvent.KEY_DOWN))
        {
            _sStage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
        }
    }

}
}
