/**
 * Created with IntelliJ IDEA.
 * User: pengwei
 * Date: 15-3-16
 * Time: 下午5:26
 * To change this template use File | Settings | File Templates.
 */
package well.display.view3d {
public class Pw3dLocator {

    private static var DISTANCE:int = 1000;
    public static var Y_OFFSET_3D:int = -90;

    public static const X_OFFSET_2D:int = -15;

    public static var cos:Number;
    public static var sin:Number;

    private static var x1:Number;
    public static var y1:Number = -500;
    private static var z1:Number;
    private static var ratio:Number;
    private static var perspective_x:Number;
    private static var perspective_y:Number;

    public static var CENTER_X:Number = 1366/2;

    public static function Init():void
    {
    }

    public function Pw3dLocator() {
    }

    public static function To3DLocation(obj3d:Pw3dObject):void
    {
        x1 = (obj3d.pos2D.x + X_OFFSET_2D)*cos - obj3d.pos2D.y * sin;
        z1 = obj3d.pos2D.y * cos + (obj3d.pos2D.x + X_OFFSET_2D) * sin;
        ratio = DISTANCE/(DISTANCE+z1);

        perspective_x = x1 * ratio;
        perspective_y = y1 * ratio;
        obj3d.ratio = ratio;

        obj3d.pos3D.x = CENTER_X + perspective_x;
        obj3d.pos3D.y = -perspective_y + Y_OFFSET_3D;
        obj3d.perspective_x = perspective_x;
        obj3d.perspective_y = perspective_y;
    }

    public static function To2DLocation(obj3d:Pw3dObject):void
    {
        var z1:Number = (y1 * DISTANCE)/(Y_OFFSET_3D - obj3d.pos3D.y) - DISTANCE;
        ratio = DISTANCE/(DISTANCE+1);

        var x1:Number = (obj3d.pos3D.x - CENTER_X)/ratio;

        if(sin == 0)
        {
            obj3d.pos2D.x = x1/cos - X_OFFSET_2D;
            obj3d.pos2D.y = z1/cos;
        }else if(cos == 0){
            obj3d.pos2D.x = z1/sin - X_OFFSET_2D;
            obj3d.pos2D.y = (-x1)/sin;
        }else{
            obj3d.pos2D.y = (z1*cos-x1*sin)/(sin*sin+cos*cos);
            obj3d.pos2D.x = (x1*cos + z1 * sin)/(cos*cos+sin*sin) - X_OFFSET_2D;
        }

        obj3d.ratio = DISTANCE/(DISTANCE+z1);
    }
}
}
