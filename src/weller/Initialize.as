/**
 * Created with IntelliJ IDEA.
 * User: pengwei
 * Date: 15-3-13
 * Time: 下午4:37
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.LoaderInfo;
import flash.display.Sprite;
import flash.events.ErrorEvent;
import flash.events.IEventDispatcher;
import flash.utils.getQualifiedClassName;

public class Initialize extends Sprite{
    public function Initialize() {
        var parameters:Object = LoaderInfo(root.loaderInfo).parameters;

        if(loaderInfo.hasOwnProperty("uncaughtErrorEvents"))
        {
            IEventDispatcher(loaderInfo["uncaughtErrorEvents"]).addEventListener("uncaughtError",uncaughtErrorHandler);
        }

    }

    private function uncaughtErrorHandler(e:ErrorEvent):void
    {
        var errorClassType:String = getQualifiedClassName(e);
        if(errorClassType.indexOf("UncaughtErrorEvent")!=-1 && e.hasOwnProperty("error"))
        {
            var errorID:int = e["error"].errorID;
            var errorMsg:String;

            if(e["error"] is Error)
            {
                var error:Error = e["error"] as Error;
                //player11.4前版本返回null
                errorMsg = error.getStackTrace();
                if(errorMsg == null)
                {
                    errorMsg = error.message;
                }
            }else if(e["error"] is ErrorEvent){
                 var errorEvent:ErrorEvent = e["error"] as ErrorEvent;
                errorMsg = errorEvent.text;
            }else{
                errorMsg = e["error"].toString();
            }

            trace("errorID:",errorID," errorMsg:",errorMsg," url:", e.target.url);
        }
    }
}
}
