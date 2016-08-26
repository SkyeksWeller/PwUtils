/**
 * Created with IntelliJ IDEA.
 * User: pengwei
 * Date: 15-3-13
 * Time: 下午3:26
 * To change this template use File | Settings | File Templates.
 */
package well.display.simpleDisplay {
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.geom.Point;

public class MouseWheelSupport {

    private static var _supportList:Vector.<MouseWheelSupport> = new <MouseWheelSupport>[];

    private var _leftSide:Number;
    private var _rightSide:Number;
    private var _topSide:Number;
    private var _bottomSide:Number;

    private var _activeCallback:Function;
    private var _completeCallback:Function;

    private var _scale:Number = 1;

    private var _scaleStep:Number;

    private var _scaleMax:Number;

    private var _scaleMin:Number;

    private var _display:InteractiveObject;

    private var _dragOffsetX:Number;
    private var _dragOffsetY:Number;

    private var _nativeWidth:int;

    private var _nativeHeight:int;




    public function MouseWheelSupport(activeCb:Function = null,completeCb:Function = null) {
        this,_activeCallback = activeCb;
        this._completeCallback = completeCb;
        _supportList.push(this);
    }

    public function setDisplay(value:InteractiveObject,scaleStep:Number = 0.1,scaleMax:Number = 1,scaleMin:Number = 0.5,dragOffsetX:Number = 0,dragOffsetY:Number = 0):void
    {
        _display = value;
        _nativeWidth = _display.width;
        _nativeHeight = _display.height;
        _scaleStep = scaleStep;
        _scaleMax = scaleMax;
        _scaleMin = scaleMin;

        _dragOffsetX = dragOffsetX;
        _dragOffsetY = dragOffsetY;
        _display.addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheelHandler);
    }

    public var xOffset:Number = 0;
    public var yOffset:Number = 0;

    private function mouseWheelHandler(e:MouseEvent):void
    {
        if(_scale == _scaleMax && e.delta>0)return;
        if(_scale == _scaleMin && e.delta<0)return;

        var changeScale:Number = e.delta>0?_scaleStep:-_scaleStep;

        var testEnd:Number = _scale+changeScale;
        testEnd = Math.round(testEnd*100)/100;

        setScale(testEnd);
    }

    public var scaleCenterPoint:Point;

    private var _goalPoint:Point = new Point(100,100);

    private var _tween:TweenMax;
    private var bigger:Boolean = false;

    public function setScale(value:Number):void
    {
        if(value>_scaleMax||value<_scaleMin)return;

        if(_tween!=null && bigger != (value>_scale))_tween.complete();

        if(_activeCallback != null)_activeCallback.apply();

        if(_goalPoint.x>0||(_tween!=null && bigger != (value>_scale)))
        {
            _goalPoint.x = _display.x;
            _goalPoint.y = _display.y;
        }

        var p:Point = scaleCenterPoint!=null?scaleCenterPoint:new Point(stage.stageWidth/2,stage.stageHeight/2);
        var xScale:Number = (-_goalPoint.x + p.x)/(_nativeWidth*_scale);
        var yScale:Number = (-_goalPoint.y + p.y)/(_nativeHeight * _scale);

        if(_tween!=null)_tween = null;
        bigger = (value>_scale);
        _scale = value;
        _goalPoint.x = p.x - _nativeWidth * xScale * _scale;
        _goalPoint.y = p.y - _nativeHeight * yScale * _scale;
        resize(_goalPoint);

        _tween = TweenMax.to(_display,0.3,{scaleX:_scale,scaleY:_scale,x:_goalPoint.x,y:_goalPoint.y,onComplete:scrollOver});
    }

    private function scrollOver():void
    {
        _goalPoint.x = 100;
        _goalPoint.y = 100;
        _tween = null;

        if(_completeCallback)_completeCallback.apply();
    }

    public function dispose():void
    {
        if(_display == null)return;
        _display.removeEventListener(MouseEvent.MOUSE_WHEEL,mouseWheelHandler);
    }

}
}
