package weller.util {

	/**
	 * 对象池接口 
	 * @author Gordon
	 * 
	 */	
	public interface IObjectPool
	{
		/**
		 *重用时重置 
		 */
		function reset():void;
		
		function disposeToPool():void;

	}
}