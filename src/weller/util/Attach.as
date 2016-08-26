/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 16-1-23
 * Time: 下午8:49
 * To change this template use File | Settings | File Templates.
 */
package weller.util {
import flash.utils.getDefinitionByName;

public class Attach {
    public function Attach() {
    }

    public static function GetClassByName(name:String):Class {
        return getDefinitionByName(name) as Class;

    }
}
}
