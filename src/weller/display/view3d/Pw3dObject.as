/**
 * Created with IntelliJ IDEA.
 * User: pengwei
 * Date: 15-3-16
 * Time: 下午4:16
 * To change this template use File | Settings | File Templates.
 */
package well.display.view3d {
import flash.geom.Point;

public class Pw3dObject {

    public var pos3D:Point;

    public var pos2D:Point;

    public var ratio:Number;

    public var perspective_x:Number;
    public var perspective_y:Number;

    public function Pw3dObject() {
        pos2D = new Point();
        pos3D = new Point();
    }

    public function setPos2D(p2x:Number,p2y:Number):void
    {
        pos2D.x = p2x;
        pos2D.y = p2y;
        Pw3dLocator.To3DLocation(this);
        update();
    }

    public function setPos3D(p3x:Number,p3y:Number):void
    {
        pos3D.x = p3x;
        pos3D.y = p3y;
        Pw3dLocator.To2DLocation(this);
        update();
    }

    public function update():void
    {

    }

    public function dispose():void
    {
        pos2D = null;
        pos3D = null;
    }

}
}
