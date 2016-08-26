/**
 * Created with IntelliJ IDEA.
 * User: pengwei
 * Date: 15-3-11
 * Time: 上午10:59
 * To change this template use File | Settings | File Templates.
 */
package well.display.simpleDisplay {
import flash.display.Sprite;
import flash.events.DataEvent;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.ui.Keyboard;

public class SkInputTextField extends Sprite{

    private var _info:TextField;
    private var _input:TextField;
    public function SkInputTextField(info:String) {

        initInfo(info);
        initInput() ;
    }

    private function initInfo(info:String):void
    {
        _info.text = info;
    }

    private function initInput():void
    {
        _input = new TextField();
        _input.type = TextFieldType.INPUT;
        var textFormat:TextFormat = new TextFormat();
        textFormat.bold = true;
        textFormat.color = 0x00ff00;
        _input.defaultTextFormat = textFormat;
        _input.width = 150;
        _input.height = 20;
        addChild(_input);

        _input.border = true;
        _input.x = 50;

        _input.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
        _input.addEventListener(Event.CHANGE,onChangeHandler);
    }

    private function onKeyDown(e:KeyboardEvent):void
    {
        if(e.keyCode == Keyboard.ENTER || e.keyCode == Keyboard.NUMPAD_ENTER)
        {
            this.dispatchEvent(new DataEvent("Enter",false,false,_input.text));
            _input.text = "";
        }
    }

    private function onChangeHandler(e:Event):void
    {
        this.dispatchEvent(new DataEvent("Change",false,false,_input.text));
    }
}
}
