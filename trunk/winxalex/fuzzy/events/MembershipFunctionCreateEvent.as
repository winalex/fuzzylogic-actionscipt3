package winxalex.fuzzy.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class MembershipFunctionCreateEvent extends Event 
	{
				
		public var data:Object;
		
		public function MembershipFunctionCreateEvent(type:String,data:Object, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			this.data = data;
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MembershipFunctionCreateEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MembershipFunctionCreateEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}