/**
 * Created with IntelliJ IDEA.
 * User: pengwei
 * Date: 15-3-10
 * Time: 下午1:42
 * To change this template use File | Settings | File Templates.
 */
package well.display.simpleDisplay {
import flash.display.Sprite;
import flash.display.Stage;
import flash.text.TextField;
import flash.text.TextFormat;

import mx.core.FlexTextField;

public class SkHelpTips extends Sprite{

    private static var _sInstance:SkHelpTips;

    public static function get Instance():SkHelpTips
    {
        if(_sInstance == null)
        {
            _sInstance = new SkHelpTips();
        }
        return _sInstance;
    }


    private var _stage:Stage;

    private var _bg:Sprite;

    private var _tf:TextField;


    public function SkHelpTips() {
        super();
        _bg = new Sprite();
        _bg.x = _bg.y = -10;
        this.addChild(_bg);

        _tf = new FlexTextField();
        var format:TextFormat = new TextFormat();
        format.color = 0xffffff;
        format.size = 14;
        _tf.defaultTextFormat = format;
        _tf.width = 300;
        _tf.height = 1200;
        _tf.mouseEnabled = false;

        this.addChild(_tf);
        this.mouseChildren = this.mouseEnabled = false;

        with(_bg.graphics)
        {
            beginFill(0x000000,0.7);
            drawRect(0,0,300,300);
            endFill();
        }
    }

    public function update(info:String,x:Number,y:Number):void
    {
        _stage.addChild(this);
        this.x = x;
        this.y = y;
        _tf.text = info;
        _bg.width = _tf.textWidth + 20;
        _bg.height = _tf.textHeight + 20;
    }

    public function hide():void
    {
        if(_stage.contains(this))
        _stage.removeChild(this);
    }
}
}
