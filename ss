;(function ($){

	$.fn._snsApi = function( opt ){

		this.each(function(){

			return new $._snsApi( this , opt );
		});

	}


	$._snsApi = function( target , opt ){
		var _this = this;
		this.target = target;
		this.opt = {

			/*参数*/
			nowUrl:null,
			medUrl:null,
			descript:null,
			key:null,
			/*设置Twitter宽度*/
			TTCodeWidthJp:null,
			TTCodeWidthFr:null,
			TTCodeWidthEs:null,
			TTCodeWidthDe:null,
			TTCodeWidthIt:null,
			TTCodeWidthRu:null,
			/*设置facebook宽度*/
			FBCodeWidthJp:null,
			FBCodeWidthFr:null,
			FBCodeWidthEs:null,
			FBCodeWidthDe:null,
			FBCodeWidthIt:null,
			FBCodeWidthRu:null,

			order:["facebook","twitter","pinterest","google1","email","vkShare","otherShare"],
			func:function( _this ,target ){}

		};

		$.extend( this.opt , opt );

		this.init();
	}

	$._snsApi.prototype = {

		init:function(){


			var langCodeMap = {

				'ja-jp': 'ja_JP',
				'fr-fr': 'fr_FR',
				'es-sp': 'es_ES',
				'de-ge': 'de_DE',
				'it-it': 'it_IT',
				'ru-ru': 'ru_RU'

			};

			this._key = this.opt.key || 'ra-4e142e195c4a0844';
			this._langCode = langCodeMap[ gvs.langcode ] || 'en_US';	
			this._descript = this.opt.descript ? this.opt.descript : "";
			this._nowUrl = this.opt.nowUrl || window.location.href;		
			this._medUrl = this.opt.medUrl ?  this.opt.medUrl : "";
			/*有description参数的URL重写*/

			this.fbUrl = this._nowUrl + (this.opt.descript && (+'&t='+ this._descript)) ;
			this.twUrl = this._nowUrl + (this.opt.descript && (+'&text='+ this._descript)) ;
			this.pinitUrl = 'http://pinterest.com/pin/create/button/?url='+ this._nowUrl + ( this._medUrl &&  '&media='+ this._medUrl ) + (this.opt.descript && (+'&description='+ this._descript));
			
			this.export();
		},
		facebook:function(){
			var FBCodeWidth = {
				'ja-jp': this.opt.FBCodeWidthJp || 131,
				'fr-fr': this.opt.FBCodeWidthFr || 116,
				'es-sp': this.opt.FBCodeWidthEs || 133,
				'de-ge': this.opt.FBCodeWidthDe || 137,
				'it-it': this.opt.FBCodeWidthIt || 126,
				'ru-ru': this.opt.FBCodeWidthRu || 160
				
			};
			var _FBWidth = FBCodeWidth[ gvs.langcode ] || 104;
			var _fbHtml = '<div class="fb-like" data-href="'+this.fbUrl+'" data-send="false" data-layout="button_count" data-width="'+ _FBWidth +'" data-show-faces="true"></div>'+
				'<scr'+'ipt type="text/javascript">'+
				'(function() {'+
				'var js, fjs = document.getElementsByTagName( "script" )[0];'+
				'if (document.getElementById( "facebook-jssdk" )) return;'+
				'js = document.createElement( "script" ); js.id = "facebook-jssdk";'+
				'js.src = "//connect.facebook.net/'+ this._langCode +'/all.js#xfbml=1";'+
				'fjs.parentNode.insertBefore(js, fjs);'+
				'})();'+
				'</scr'+'ipt>';

			return _fbHtml;

		},
		twitter:function(){
			var TTCodeWidth = {
				'ja-jp': this.opt.TTCodeWidthJp || 131,
				'fr-fr': this.opt.TTCodeWidthFr || 116,
				'es-sp': this.opt.TTCodeWidthEs || 133,
				'de-ge': this.opt.TTCodeWidthDe || 137,
				'it-it': this.opt.TTCodeWidthIt || 126,
				'ru-ru': this.opt.TTCodeWidthRu || 160
				
			};
			var _TTWidth = TTCodeWidth[ gvs.langcode ] || 89;
			var _twitterHtml = '<div class="tweet">'+
				'<a href="https://twitter.com/share" class="twitter-share-button" data-url="'+this.twUrl+'" data-width="'+ _TTWidth +'" data-lang="'+ this._langCode +'">Twitter</a>'+
				'</div>'+
				'<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id))'+
				'{js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js?lang='+ this._langCode +'";fjs.parent'+
				'Node.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>';

			return _twitterHtml;
		},
		pinterest:function(){

			var _pintrestHtml ='<div class="pinit">'+
				'<div class="pinit_a">'+
				'<a href="'+ this.pinitUrl +'"'+
				'class="pin-it-button" count-layout="horizontal">Pin It</a></div>'+
				'<scr'+'ipt type="text/javascript" src="http://assets.pinterest.com/js/pinit.js"></scr'+'ipt>'+
				'</div>'+
				'<div class="img_000"></div>';

			return _pintrestHtml;

		},
		google1:function(){

			var _google1Html = '<div class="google_1">'+
				'<a class="addthis_button_google_plusone" g:plusone:size="medium" ></a>'+
				'</div>'+
				'<scr'+'ipt type="text/javascript" src="//apis.google.com/js/plusone.js">'+
				'</scr'+'ipt>';

			return _google1Html;
		},
		email:function(){

			var _emailHtml = '<div class="eamil">'+
				'<a href="http://www.addthis.com/bookmark.php" class="addthis_button_email"></a>'+
				'</div>';

			return _emailHtml;
		},
		otherShare:function(){

			var otherShareHtml = '<div class="share">'+
				'<a class="addthis_counter addthis_pill_style" ></a>'+
				'</div>';

			return otherShareHtml;
		},
		vkShare:function(){
			/*only [ru] use */
			var vkShareHtml = '<div id="vk_share_button"></div><scr'+'ipt type="text/javascript" src="//vkontakte.ru/js/api/share.js?9" charset="windows-1251"></scr'+'ipt>';	

			return vkShareHtml;

		},
		export:function(){
			var _this = this;
			var _snsScript = '<scr'+'ipt type="text/javascript" src="//s7.addthis.com/js/250/addthis_widget.js#pubid='+this._key+'"></scr'+'ipt>';

			

			this.opt.func.call(this);



			var sns_type = {

				facebook : this.facebook() ,	
				twitter :  this.twitter() ,
				pinterest : this.pinterest(),
				google1 :  this.google1(),
				email  :  this.email(),
				otherShare : this.otherShare(),
				vkShare : ( this._langCode=='ru_RU' ? true : "" ) && this.vkShare()
			}
		
			var  _strhtml ="";

			for (var i = 0; i < this.opt.order.length; i++) {
				
			
				var s = this.opt.order[i] + "" ;

				_strhtml += sns_type[ s ];

			};

			var _snsHtml = "<div class='sns_all' >"+ _strhtml + _snsScript+"</div>";

		

			$( _this.target ).html( _snsHtml   );


			if( _this.opt.vkShare && _this._langCode=='ru_RU' ){

				if( $("#vk_share_button") ){
					function VK_delay(){
						if(VK){
							$('#vk_share_button').html(VK.Share.button(
								{url: false,image:  _this._medUrl ? _this._medUrl :"" }, 
								{type: 'custom',text:'<img src="http://vk.com/images/vk32.png" />'}
							));
							clearInterval(vkTimer);
						}
					}
					var vkTimer = setInterval(VK_delay,2000);	
				}
				

			}

		

		}

	}


})(jQuery)
