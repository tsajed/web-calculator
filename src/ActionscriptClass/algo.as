package ActionscriptClass
{
	public class algo
	{

		public var str:String;
		
		public function algo(string:String)
		{
			var d:Data = new Data();
			
			d.MString = string;
			
			if (paran_check(d) == 0) {
				str = "Paranthesis not matched";
			}
			
			else {
			
				remove_ws(d);
				
				l_paranth(d);
				
				str = d.MString;
			}
			
			//var num:Number = new Number(d.MString);
			
			//str = num.toFixed(3);
		}
		
			
		public function lrp_check(d:Data):void {
			
			d.unite[0] = new Number(d.unite[0]);
			var s:String = "";
			
			if(d.MString.charAt(d.lp - 1) == ")") {
				d.unite[0] = s.concat("*", d.unite[0].toString());
			}
			if(d.MString.charAt(d.rp + 1) == "(") {
				d.unite[0] = s.concat(d.unite[0].toString(), "*");
			}
			
			if(d.MString.charAt(d.lp - 1).match(/\d/)) {
				d.unite[0] = s.concat("*", d.unite[0].toString());
			}
			
			if(d.MString.charAt(d.rp + 1).match(/\d/))  {
				d.unite[0] = s.concat(d.unite[0].toString(), "*");
			}
			

			d.unite[0] = d.unite[0].toString();
			
			if(d.MString.match(/\([^\(\)]*\)/)) {
				d.MString = d.MString.replace(/\([^\(\)]*\)/, d.unite[0]); 
			}
			
			else {
				
					d.MString = d.unite[0];
				}
			
			d.unite = new Array();
			d.unito = new Array();
			d.lp = -2;
			d.rp = -2;
			
		}
		
		public function remove_ws (d:Data):void {
			
			while(d.MString.match(/( )+/)) {
				d.MString = d.MString.replace(/( )+/, "");
			}
			
		}
		
		public function l_paranth(d:Data):void {
    
	        var string:String = d.MString;
			
	       while(1) {
		
	           var a:int = string.search(/[\(\)]/);
			   if(a == -1) {
				   break;
			   }
	            
	           if (string.charAt(a) == "(") {
	                string = string.replace(/[\(\)]/, " ");
	                
	               var b:int = string.search(/[\(\)]/);
	               if(string.charAt(b) == ")") {
						
						d.lp = a;
						d.rp = b;
						
	                    d.parenth = string.substring(a+1, b);
						string = string.replace(/[\(\)]/, " ");
	                    Analyze(d);
	                    string = d.MString;
	                }
	            }
	        }
			
			d.parenth = d.MString;
			Analyze(d);
		}
      
        
              
        
        public function Analyze(d:Data):void {
		   
        	simplify_op(d);
			
			addsub_op(d);
			
			pdm_op(d);
			
			add_sub(d);
			
			lrp_check(d);
			
		}
        
        public function simplify_op(d:Data):void {
    
			var pattern:RegExp = new RegExp("[\+-][\+-]");
			var s:String = d.parenth;
	        while(1) {
	            var b:Number = d.parenth.search(/[\+-][\+-]/);
				if (b == -1) {
					break;
				}
	            var lo:String = d.parenth.charAt(b);
	            var hi:String = d.parenth.charAt(b+1);
	            
	            if(lo == hi) {
	                d.parenth = d.parenth.replace(/[\+-][\+-]/, "+");
	            }
	            else {
	                d.parenth = d.parenth.replace(/[\+-][\+-]/, "-");
	            }
			}
		}   

        
        public function addsub_op(d:Data):void {
    
	        var c:int = -1;
			
			var k:int = d.parenth.search(/[\+-]/); 
			
			if(k == 0) {
					
					d.unito.push(d.parenth.charAt(b));
					d.parenth = d.parenth.replace(/[\+-]/, " ");					
				}
			
			else {
					
					d.unito.push("+");
				}
			
	        while(d.parenth.match(/[\+-]/)) {
	        
	            var b:int = d.parenth.search(/[\+-]/);
	            var exp:String = d.parenth.substring(c+1, b);
	            
	            
	            if(!(exp.match(/[\/\*\^]$/))) { 
					            
	                d.unite.push(exp);
	            
					d.unito.push(d.parenth.charAt(b));
	                d.parenth = d.parenth.replace(/[\+-]/, " ");
					
	                c = b;
	            }
	            
	            else {
	                if(d.parenth.charAt(b) == "+") {
	                    d.parenth = d.parenth.replace(/[\+-]/, "");
	                }
	                
	                else {
	                    d.parenth = d.parenth.replace(/[\+-]/, "S");
	                }
	            }
			}
			
	       d.unite.push(d.parenth.substring(c+1, d.parenth.length));

		}
      		
	
			
		public function pdm_op(d:Data):void {
   
			
		    for(var i:int = 0 ; i < d.unite.length; i++) {
		    
		        d.parenth = d.unite[i];
				var c:int = -1;
				
		        while(d.parenth.match(/[\/\*]/)) {
		        
		            var b:int = d.parenth.search(/[\/\*]/);
		            
		            if (d.parenth.charAt(b+1) == "S") {
		                d.parenth = d.parenth.replace(/S/, "-");
		            }
		            
		            d.dunito.push(d.parenth.charAt(b));
		            
		            d.dunite.push(d.parenth.substring(c+1, b));
		    
		            c = b;
					
					d.parenth = d.parenth.replace(/[\/\*]/, " ");
		        }
				
		        d.dunite.push(d.parenth.substring(c+1, d.parenth.length));
				
				podimu_op(d);
				
				d.unite[i] = d.dunite[0];
				
				d.dunite = new Array();
				d.dunito = new Array();
		    }
		}
		
		public function podimu_op(d:Data) : void {
			
			var num:Number = new Number();
			
			for( var i:int =0; i<d.dunite.length; i++ ) {
				if(d.dunite[i].match(/[\^]/)) {
					var array:Array = d.dunite[i].split(/[\^]/);

					for(var j:int = array.length - 1; j>0; j--) {
						array[j-1] = Math.pow(Number(array[j-1]), Number(array[j]));
					}
					
					d.dunite[i] = array[0];
				}
			}
			
			for(var k:int = 0; k < d.dunito.length; k++) {
				if(d.dunito[k] == "*") {
					d.dunite[0] = Number(d.dunite[0]) * Number(d.dunite[k+1]);
				}
				else if(d.dunito[k] == "/") {
					d.dunite[0] = Number(d.dunite[0]) / Number(d.dunite[k+1]);
				}
			}
	
		}
		
		public function add_sub(d:Data):void {
			
			if(d.unito[0] == "-") {
				d.unite[0] = -Number(d.unite[0]);
			}
			
			for(var i:int = 1; i<d.unite.length; i++) {
				if(d.unito[i] == "-") {
					d.unite[i] = -Number(d.unite[i]);
				}
				d.unite[0] = Number(d.unite[0])+ Number(d.unite[i]);
			}
		}
		
		public function paran_check(d:Data):int {
			
			var s:String = d.MString;
			var lep:int = 0;
			var rip:int = 0;
			
			for(var i:int = 0; i<s.length; i++) {
				
				if(s.charAt(i) == "(") {
					lep++;
				}
				else if(s.charAt(i) == ")") {
					rip++;
				}
			}
			if(lep == rip) {
				return 1;
			}
			else {
				return 0;
			}
			
		}
 
	}
}

//pdm_op and podimu_op to be investigated.
//problems with 5(x) and (x)(y), that is lrp_check