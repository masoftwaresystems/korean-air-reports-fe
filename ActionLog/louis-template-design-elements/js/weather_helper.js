// Helper functions to get the weather information via Ajax on the client side

$(document).ready(function() {
	function RandomTextGenerator() {
		var characters = new Array ();
		characters[0] = "a";
		characters[1] = "b";
		characters[2] = "c";
		characters[3] = "d";
		characters[4] = "e";
		characters[5] = "f";
		characters[6] = "g";
		characters[7] = "h";
		characters[8] = "i";
		characters[9] = "j";
		characters[10] = "k";
		characters[11] = "l";
		characters[12] = "m";
		characters[13] = "n";
		characters[14] = "o";
		characters[15] = "p";
		characters[16] = "q";
		characters[17] = "r";
		characters[18] = "s";
		characters[19] = "t";
		characters[20] = "u";
		characters[21] = "v";
		characters[22] = "w";
		characters[23] = "x";
		characters[24] = "y";
		characters[25] = "0";
		characters[26] = "1";
		characters[27] = "2";
		characters[28] = "3";
		characters[29] = "4";
		characters[30] = "5";
		characters[31] = "6";
		characters[32] = "7";
		characters[33] = "8";
		characters[34] = "9";
		characters[35] = "0";
	
		var textOutput = "";
		for (var i = 0; i <= 5; i++) {
			var randomNumber = Math.floor(36 * Math.random());
			textOutput = textOutput + characters[randomNumber];
		}

		return textOutput;
	}
	
	var randomText = "abc=" + RandomTextGenerator();
	
	$.ajax({
		url: '/templates/Weather_Helper?' + randomText,
		dataType: 'json',
		success: function(data, textStatus) {
			var currentTemperature = data.CurrentTemperature;
			var skyCondition = data.SkyCondition;
			var lowTemperature = data.LowTemp;
			var highTemperature = data.HighTemp;
			var weatherImage = data.Icon;

			$('#weather').append('<img id=\"weatherImage\" alt=\"\" src=\"' + weatherImage + '\" />');
			$('#weather').append('<p id=\"temperature\">' + currentTemperature + ' F</p>');
			$('#weather').append('<p class=\"hiLow\">Hi: ' + highTemperature + ' Low: ' + lowTemperature + '</p>');

		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
			var dummy = textStatus;
			var dummy2 = errorThrown;
			// Do nothing
		}
	});
});

