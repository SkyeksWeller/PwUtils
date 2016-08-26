/**
 * Created with IntelliJ IDEA.
 * User: pengwei
 * Date: 15-3-10
 * Time: 下午1:33
 * To change this template use File | Settings | File Templates.
 */
package well.display.simpleDisplay {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

public class SkButton extends Sprite{

    private var _tf:TextField;

    private var _tips:String;

    public function SkButton(name:String,tips:String = null) {
        _tf = new TextField();
        this.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
        this.addEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
        this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
        this.addEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);

        onRollOutHandler(null);
        addChild(_tf);

        var format:TextFormat = new TextFormat();
        format.size = 14;
        format.bold = true;
        format.color = 0xFFFFFF;
        _tf.defaultTextFormat = format;

        _tf.text = name;
        _tf.mouseEnabled = false;
        _tf.height = 20;
        _tf.width = 50;

        this.buttonMode = true;
        _tips = tips;
    }

    private function onMouseUpHandler(event:MouseEvent):void {
        this.y -=-1;
    }



    private function onMouseDownHandler(event:MouseEvent):void {
        this.y+=-1;
    }

    private function onRollOutHandler(event:MouseEvent):void {
        setColor(0xf87653);
        _tf.textColor = 0xffffff;

        if(_tips)
        {
            SkHelpTips.Instance.hide();
        }
    }

    private function onRollOverHandler(event:MouseEvent):void {
        setColor(0xFFFFFF);
        _tf.textColor = 0x000000;

        if(_tips)
        {
            SkHelpTips.Instance.update(_tips,this.x+this.width,this.y+this.height);
        }
    }

    private function setColor(color:uint):void
    {
        with(this.graphics)
        {
            clear();
            beginFill(color);
            drawRect(-10,0,60,20);
            endFill();
        }
    }
}
}
