package st.crexi.as3.framework.cafe.core.interfaces
{	
	
	/**
	 * SingleTonクラスとそのクラスに対するラベル(String)の対応をさせるクラスのInterfaceです
	 *
	 * @author kaora crexista
	 * 
	 */	
	public interface IDISingletonRule
	{
		
		/**
		 * 変換します
		 * @param klass
		 * @return 
		 * 
		 */		
		function exchange(orderClass:Class):String;
	}
}