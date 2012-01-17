package st.crexi.as3.framework.cafe.core
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	import mx.events.PropertyChangeEvent;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.core.interfaces.IHall;
	import st.crexi.as3.framework.cafe.core.interfaces.ITask;

	/**
	 * 使用するAspectクラスを列挙するリストクラスです
	 * 
	 * @author kaoru_shibasaki
	 * 
	 */	
	public class AbstractHall
	{


		/**
		 * taskを起動させます<br/>
		 * taskを起動させ、task実行に必要なrequestにバインドさせます<br/>
		 * 
		 */		
		protected function taskInvoke():void
		{
			var iTable:IHall = IHall(this);
			var task:ITask;
			
			for each(var klass:Class in iTable.taskClasses) {
				task = new klass();
				
				for each (var request:IRequest in task.dependencies) {
					Kitchen.instance.register(request, task);
				}
			}			
		}
		

		
		/**
		 * コンストラクタです
		 * 
		 */		
		public function AbstractHall()
		{
			taskInvoke();
		}
	}
}