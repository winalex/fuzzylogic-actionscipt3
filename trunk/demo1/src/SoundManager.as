package  
{
	import flash.media.Sound;
	/**
	 * ...
	 * @author ...
	 */
	public class SoundManager 
	{
		static private var _instance;
		private var _shootGunSound:Sound;
		private var _pistolFireSound:Sound;
		private var _solderKnifeDieSound:Sound;
		private var _solderMissleDieSound:Sound;
		
		//*************************************************
		// GET INSTANCE (SINGLETON)
		// ************************************************
		public static function getInstance():SoundManager {
			if(_instance == null) _instance = new SoundManager();
			return _instance;
		}
		
		public function SoundManager() 
		{
			
		}
		
		public function get shootGunSound():Sound 
		{
			if (!_shootGunSound) _shootGunSound = new ShotGunFireSound();
						
			return _shootGunSound;
		}
		
		public function get solderKnifeDieSound():Sound 
		{
			
			if (!_solderKnifeDieSound) _solderKnifeDieSound =new SolderKnifeDieSound();
			return _solderKnifeDieSound;
		}
		
		public function get solderMissleDieSound():Sound 
		{
			if (!_solderMissleDieSound) _solderMissleDieSound = new SolderMissleDieSound();
			return _solderMissleDieSound;
		}
		
		public function get pistolFireSound():Sound 
		{
			if (!_pistolFireSound) _pistolFireSound = new PistolFireSound();
			return _pistolFireSound;
		}
		
	}

}