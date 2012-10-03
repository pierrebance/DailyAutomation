package com
{
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.*;
	import flash.utils.*;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	
	public class FileDownloader extends EventDispatcher
	{
			[Bindable]
			private var urlStream:URLStream;
			private var fileData:ByteArray;
			private var fileStream:FileStream;
			private var folder:File;
			private var file:File;
	        
	        public var urlFile:String;
	        public var fileName:String;
			
	     	
	        public function FileDownloader():void{
	        }
	        
	        public function Start(_urlFile:String, _folder:File, _fileName:String):void{
	        	urlFile = _urlFile;
	        	fileName = _fileName;	
	        	folder = _folder;
				
	        	file = new File(folder.nativePath.toString() + "/" + fileName);	
	        	DownoadFile();	
	        }
			
	        
	        private function StartDownloadStream():void{
				var req:URLRequest = new URLRequest(urlFile);
	        	urlStream = new URLStream();
				urlStream.addEventListener(ProgressEvent.PROGRESS, onProgressWriteFile);
				urlStream.load(req);
	        }
			
	        private function DownoadFile():void{
	        	OpenFileForWrite();
	        	StartDownloadStream();
	        }
	        
	        private function OpenFileForWrite():void{
	        	fileStream = new FileStream();
				fileStream.open(file, FileMode.WRITE);
	        }
	        
			private function onProgressWriteFile(evt:ProgressEvent):void {
				var fileDataChunk:ByteArray = new ByteArray();
				urlStream.readBytes(fileDataChunk,0,urlStream.bytesAvailable);
				fileStream.writeBytes(fileDataChunk,0,fileDataChunk.length);
				
				if(evt.bytesLoaded == evt.bytesTotal){
					urlStream.removeEventListener(ProgressEvent.PROGRESS, onProgressWriteFile);
					urlStream.close();
					fileStream.close();
					
					dispatchEvent(new Event(Event.COMPLETE, true, true));
				}
				
				dispatchEvent(evt);
	        }

	}
}
