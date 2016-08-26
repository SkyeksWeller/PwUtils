/**
 * Created with IntelliJ IDEA.
 * User: pengwei
 * Date: 15-3-16
 * Time: 下午4:12
 * To change this template use File | Settings | File Templates.
 */
package well.display.view3d {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.utils.Dictionary;

public class Pw3dSprite extends Sprite{

    private var _childRatioIndex:Dictionary;

    public function Pw3dSprite() {
        super();
    }

    public function set3dChildIndex(child:DisplayObject,index:Number):void
    {
        _childRatioIndex[child] = index;
        for(var i:int = 0;i<this.numChildren;i++)
        {
            if(_childRatioIndex[this.getChildAt(i)] && _childRatioIndex[this.getChildAt(i)]>index)
            {
                super.setChildIndex(child,i);
                return;
            }
        }
        super.addChild(child);
    }


}
}
