/**
 * Created by wellerpeng on 2016/1/21.
 */
package weller.util
{

	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class TextFieldUtil
	{

		public static  function GetTextField( color:uint, size:uint, align:String, w:int, h:int, bold:Boolean = false, stroke:int = 3 ):TextField
		{
			var tf:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.font = "Microsoft YaHei";
			format.align = align;
			format.size = size;
			format.color = color;
			format.bold = bold;
			tf.defaultTextFormat = format;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.width = w;
			tf.height = h;
			tf.filters = [new GlowFilter( 0x000000, 1, stroke, stroke, 10 )];
			tf.selectable = false;
            tf.mouseEnabled = false;
			return tf;
		}
	}
}
