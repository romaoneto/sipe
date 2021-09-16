<?php

//include_once('PHPMailer_v5.1/class.phpmailer.php');

function codigo_email($uid1, $uid2){
        //fun��o utilizada at� o processo de 04/14
        $ano=date('Y');
        $mes=date('m');

        $codigo=0;
        for($i=0;$i<strlen($uid1);$i++){
                $codigo+=substr($uid1, $i, 1);
                //echo $codigo.': '.substr($uid1, $i, 1).'<br>';
        }

        for($i=0;$i<strlen($uid2);$i++){
                $codigo+=substr($uid2, $i, 1);
                //echo $codigo.': '.substr($uid2, $i, 1).'<br>';
        }

        $codigo+=$uid2;
        //echo $codigo.": $uid2<br>";
        for($i=0;$i<4;$i++){
                $codigo+=substr($ano, $i, 1);
                //echo $codigo.': '.substr($ano, $i, 1).'<br>';
        }
        for($i=0;$i<2;$i++){
                $codigo+=substr($mes, $i, 1);
                //echo $codigo.': '.substr($mes, $i, 1).'<br>';
        }
        $codigo+=618;

        for($i=0;$i<10;$i++){
                if(digitoMASP($codigo.$i)){
                        $codigo=$codigo.$i;
                        break;
                }
        }

        return $codigo;
}

function exibir_MASP($masp){
        return substr($masp, 0, -1).'-'.substr($masp, -1);
}

function exibir_cpf($cpf){
        return substr($cpf, 0, 3).'.'.substr($cpf, 3, 3).'.'.substr($cpf, 6, 3).'-'.substr($cpf, -2);
}

function delmagic( $value ){
	// this function removes backslashes if magic_quotes_gpc is on
	if( get_magic_quotes_gpc() ) return stripslashes( $value );
	else return $value;
}

function show_date( $date, $showtime=false ){
	if(strlen($date)==0){
		return "";
	}
	$date_str = substr($date,8,2).'/'.substr($date,5,2).'/'.substr($date,0,4);

	if( $showtime ) $date_str .= ' '.substr($date,11,5);
	return $date_str;
}

function show_sql_date( $date, $showtime=false ){
	if(strlen($date)==0){
		return '';
	}
        if(!strstr($date, '/') && strlen($date)==8){
                $date_str = substr($date,4,4).'-'.substr($date,2,2).'-'.substr($date,0,2);
                if( $showtime ) $date_str .= ' '.substr($date,9,5);
        }
        else{
                $date_str = substr($date,6,4).'-'.substr($date,3,2).'-'.substr($date,0,2);
                if( $showtime ) $date_str .= ' '.substr($date,11,5);
        }

	return $date_str;
}

function show_time($hora){
        if(strlen($hora)>0){
                if($hora<0){
                        $resposta.='-';
                        $hora*=-1;
                }
                if(floor($hora/60)>=10){
                        $resposta.= floor($hora/60).':';
                }
                else{
                        $resposta.= '0'.floor($hora/60).':';
                }
                if(($hora%60)>=10){
                        $resposta.= ($hora%60);
                }
                else{
                        $resposta.= '0'.($hora%60);
                }
        }
        return $resposta;
}

function show_time_reverso($hora){
        if(strlen($hora)>0){
                $time=explode(':', $hora);
                $resposta=($time[0]*60)+$time[1];
        }
        return $resposta;
}

function mes($mes){
	if($mes == 1){
		return 'janeiro';
	}
	else if($mes == 2){
		return 'fevereiro';
	}
	else if($mes == 3){
		return 'mar�o';
	}
	else if($mes == 4){
		return 'abril';
	}
	else if($mes == 5){
		return 'maio';
	}
	else if($mes == 6){
		return 'junho';
	}
	else if($mes == 7){
		return 'julho';
	}
	else if($mes == 8){
		return 'agosto';
	}
	else if($mes == 9){
		return 'setembro';
	}
	else if($mes == 10){
		return 'outubro';
	}
	else if($mes == 11){
		return 'novembro';
	}
	else if($mes == 12){
		return 'dezembro';
	}
}

function checa_data($data){
	if(strlen($data)==0){
		return false;
	}
	else if(strstr($data, '/')){
		$partes = explode('/', $data);
                if(checkdate($partes[1], $partes[0], $partes[2]) && is_numeric($partes[1]) && is_numeric($partes[0]) && is_numeric($partes[2])){
			return true;
		}
	}
	else if(strstr($data, '-')){
		$partes = explode('-', $data);
                if(checkdate($partes[1], $partes[2], $partes[0]) && is_numeric($partes[1]) && is_numeric($partes[2]) && is_numeric($partes[0])){
			return true;
		}
	}
	return false;
}

function padraoSenha($senha){
	$erro='';
	if( strlen($senha) < 8 ) {
		$erro .= 'O tamanho m�nimo para a senha s�o 8 caracteres.<br />';
	}
	if( strlen($senha) > 20 ) {
		$erro .= 'O tamanho m�ximo para a senha s�o 20 caracteres.<br />';
	}
	if( !ereg("[0-9].*[0-9]", $senha) ) {
		$erro .= 'A senha deve incluir ao menos 2 algarismos.<br />';
	}
	if( !ereg("[a-z].*[a-z].*[a-z]", $senha) ) {
		$erro .= 'A senha deve incluir ao menos 3 letras min�sculas.<br />';
	}
	if( !ereg("[A-Z]+", $senha) ) {
		$erro .= 'A senha deve incluir ao menos 1 letra em mai�sculo.<br />';
	}
	if( !preg_match("#\W+#", $senha) ) {
		$erro .= 'A senha deve incluir ao menos um caractere especial.<br />';
	}
	return $erro;
}

function padraoSenhaFacil($senha){
	$erro='';
	if( strlen($senha) < 8 ) {
		$erro .= 'O tamanho m�nimo para a senha s�o 8 caracteres.<br />';
	}
	if( strlen($senha) > 20 ) {
		$erro .= 'O tamanho m�ximo para a senha s�o 20 caracteres.<br />';
	}
	return $erro;
}

function verificaCPF($cpf) {
	$cpf = str_replace('.', '', $cpf);
        if(strlen($cpf)==11){
                $cpf= substr($cpf, 0, 9).'-'.substr($cpf, 9);
        }
	if (strlen($cpf) <> 12){
                return 0;
        }
	$soma1 = ($cpf[0] * 10) +
				($cpf[1] * 9) +
				($cpf[2] * 8) +
				($cpf[3] * 7) +
				($cpf[4] * 6) +
				($cpf[5] * 5) +
				($cpf[6] * 4) +
				($cpf[7] * 3) +
				($cpf[8] * 2);
        $resto = $soma1 % 11;
	$digito1 = $resto < 2 ? 0 : 11 - $resto;

	$soma2 = ($cpf[0] * 11) +
				($cpf[1]  * 10) +
				($cpf[2]  * 9) +
				($cpf[3]  * 8) +
				($cpf[4]  * 7) +
				($cpf[5]  * 6) +
				($cpf[6]  * 5) +
				($cpf[7]  * 4) +
				($cpf[8]  * 3) +
				($cpf[10] * 2);
	$resto = $soma2 % 11;
	$digito2 = $resto < 2 ? 0 : 11 - $resto;

	return (($cpf[10] == $digito1) && ($cpf[11] == $digito2));
}

function verificaCGC($cgc) {
	if (strlen($cgc) <> 18) return 0;
	$soma1 = ($cgc[0] * 5) +
				($cgc[1] * 4) +
				($cgc[3] * 3) +
				($cgc[4] * 2) +
				($cgc[5] * 9) +
				($cgc[7] * 8) +
				($cgc[8] * 7) +
				($cgc[9] * 6) +
				($cgc[11] * 5) +
				($cgc[12] * 4) +
				($cgc[13] * 3) +
				($cgc[14] * 2);
        $resto = $soma1 % 11;
	$digito1 = $resto < 2 ? 0 : 11 - $resto;

	$soma2 = ($cgc[0] * 6) +
				($cgc[1] * 5) +
				($cgc[3] * 4) +
				($cgc[4] * 3) +
				($cgc[5] * 2) +
				($cgc[7] * 9) +
				($cgc[8] * 8) +
				($cgc[9] * 7) +
				($cgc[11] * 6) +
				($cgc[12] * 5) +
				($cgc[13] * 4) +
				($cgc[14] * 3) +
				($cgc[16] * 2);
	$resto = $soma2 % 11;
	$digito2 = $resto < 2 ? 0 : 11 - $resto;

	return (($cgc[16] == $digito1) && ($cgc[17] == $digito2));
}

function retira_acentos($nome){
	$caracteres = array();
	$caracteres[0][0] = '�';
	$caracteres[0][1] = 'a';
	$caracteres[1][0] = '�';
	$caracteres[1][1] = 'a';
	$caracteres[2][0] = '�';
	$caracteres[2][1] = 'a';
	$caracteres[3][0] = '�';
	$caracteres[3][1] = 'a';
	$caracteres[4][0] = '�';
	$caracteres[4][1] = 'e';
	$caracteres[5][0] = '�';
	$caracteres[5][1] = 'e';
	$caracteres[6][0] = '�';
	$caracteres[6][1] = 'e';
	$caracteres[7][0] = '�';
	$caracteres[7][1] = 'i';
	$caracteres[8][0] = '�';
	$caracteres[8][1] = 'i';
	$caracteres[9][0] = '�';
	$caracteres[9][1] = 'o';
	$caracteres[10][0] = '�';
	$caracteres[10][1] = 'o';
	$caracteres[11][0] = '�';
	$caracteres[11][1] = 'o';
	$caracteres[12][0] = '�';
	$caracteres[12][1] = 'o';
	$caracteres[13][0] = '�';
	$caracteres[13][1] = 'u';
	$caracteres[14][0] = '�';
	$caracteres[14][1] = 'c';
	$caracteres[15][0] = '�';
	$caracteres[15][1] = 'a';
	$caracteres[16][0] = '�';
	$caracteres[16][1] = 'a';
	$caracteres[17][0] = '�';
	$caracteres[17][1] = 'A';
	$caracteres[18][0] = '�';
	$caracteres[18][1] = 'A';
	$caracteres[19][0] = '�';
	$caracteres[19][1] = 'E';
	$caracteres[20][0] = '�';
	$caracteres[20][1] = 'E';
	$caracteres[21][0] = '�';
	$caracteres[21][1] = 'E';
	$caracteres[22][0] = '�';
	$caracteres[22][1] = 'I';
	$caracteres[23][0] = '�';
	$caracteres[23][1] = 'I';
	$caracteres[24][0] = '�';
	$caracteres[24][1] = 'O';
	$caracteres[25][0] = '�';
	$caracteres[25][1] = 'O';
	$caracteres[26][0] = '�';
	$caracteres[26][1] = 'O';
	$caracteres[27][0] = '�';
	$caracteres[27][1] = 'O';
	$caracteres[28][0] = '�';
	$caracteres[28][1] = 'U';
	$caracteres[29][0] = '�';
	$caracteres[29][1] = 'C';
	//$caracteres[30][0] = ' ';
	//$caracteres[30][1] = '';
	$caracteres[31][0] = '&';
	$caracteres[31][1] = '';

        foreach($caracteres as $linha){
                $string = str_replace($linha[0], $linha[1], $string);
        }
	return $string;
}
function valorPorExtenso($valor = 0) {

	// funcao............: valorPorExtenso
	// ---------------------------------------------------------------------------
	// desenvolvido por..: andr� camargo
	// versoes...........: 0.1 19:00 14/02/2000
	//                     1.0 12:06 16/02/2000
	// descricao.........: esta fun��o recebe um valor num�rico e retorna uma
	//                     string contendo o valor de entrada por extenso
	// parametros entrada: $valor (formato que a fun��o number_format entenda :)
	// parametros sa�da..: string com $valor por extenso

	$singular = array('centavo', 'real', 'mil', 'milh�o', 'bilh�o', 'trilh�o', 'quatrilh�o');
	$plural = array('centavos', 'reais', 'mil', 'milh�es', 'bilh�es', 'trilh�es', 'quatrilh�es');

	$c = array('', 'cem', 'duzentos', 'trezentos', 'quatrocentos', 'quinhentos', 'seiscentos', 'setecentos', 'oitocentos', 'novecentos');
	$d = array('', 'dez', 'vinte', 'trinta', 'quarenta', 'cinquenta', 'sessenta', 'setenta', 'oitenta', 'noventa');
	$d10 = array('dez', 'onze', 'doze', 'treze', 'quatorze', 'quinze', 'dezesseis', 'dezessete', 'dezoito', 'dezenove');
	$u = array('', 'um', 'dois', 'tr�s', 'quatro', 'cinco', 'seis', 'sete', 'oito', 'nove');

	$z=0;

	$valor = number_format($valor, 2, '.', '.');
	$inteiro = explode(".", $valor);
	for($i=0;$i<count($inteiro);$i++){
		for($ii=strlen($inteiro[$i]);$ii<3;$ii++){
			$inteiro[$i] = "0".$inteiro[$i];
                }
        }
	// $fim identifica onde que deve se dar jun��o de centenas por "e" ou por "," ;)
	$fim = count($inteiro) - ($inteiro[count($inteiro)-1] > 0 ? 1 : 2);
	for ($i=0;$i<count($inteiro);$i++) {
		$valor = $inteiro[$i];
		$rc = (($valor > 100) && ($valor < 200)) ? "cento" : $c[$valor[0]];
		$rd = ($valor[1] < 2) ? "" : $d[$valor[1]];
		$ru = ($valor > 0) ? (($valor[1] == 1) ? $d10[$valor[2]] : $u[$valor[2]]) : "";

		$r = $rc.(($rc && ($rd || $ru)) ? " e " : "").$rd.(($rd && $ru) ? " e " : "").$ru;
		$t = count($inteiro)-1-$i;
		$r .= $r ? " ".($valor > 1 ? $plural[$t] : $singular[$t]) : "";
		if ($valor == "000")$z++; elseif ($z > 0) $z--;
		if (($t==1) && ($z>0) && ($inteiro[0] > 0)) $r .= (($z>1) ? " de " : "").$plural[$t];
		if ($r) $rt = $rt . ((($i > 0) && ($i <= $fim) && ($inteiro[0] > 0) && ($z < 1)) ? ( ($i < $fim) ? ", " : " e ") : " ") . $r;
	}

	return($rt ? $rt : "zero");
}

function convert_number_to_words($number) {

    $hyphen      = '-';
    $conjunction = ' e ';
    $separator   = ', ';
    $negative    = 'menos ';
    $decimal     = ' ponto ';
    $dictionary  = array(
        0                   => 'zero',
        1                   => 'um',
        2                   => 'dois',
        3                   => 'tr�s',
        4                   => 'quatro',
        5                   => 'cinco',
        6                   => 'seis',
        7                   => 'sete',
        8                   => 'oito',
        9                   => 'nove',
        10                  => 'dez',
        11                  => 'onze',
        12                  => 'doze',
        13                  => 'treze',
        14                  => 'quatorze',
        15                  => 'quinze',
        16                  => 'dezesseis',
        17                  => 'dezessete',
        18                  => 'dezoito',
        19                  => 'dezenove',
        20                  => 'vinte',
        30                  => 'trinta',
        40                  => 'quarenta',
        50                  => 'cinquenta',
        60                  => 'sessenta',
        70                  => 'setenta',
        80                  => 'oitenta',
        90                  => 'noventa',
        100                 => 'cento',
        200                 => 'duzentos',
        300                 => 'trezentos',
        400                 => 'quatrocentos',
        500                 => 'quinhentos',
        600                 => 'seiscentos',
        700                 => 'setecentos',
        800                 => 'oitocentos',
        900                 => 'novecentos',
        1000                => 'mil',
        1000000             => array('milh�o', 'milh�es'),
        1000000000          => array('bilh�o', 'bilh�es'),
        1000000000000       => array('trilh�o', 'trilh�es'),
        1000000000000000    => array('quatrilh�o', 'quatrilh�es'),
        1000000000000000000 => array('quinquilh�o', 'quinquilh�es')
    );

    if (!is_numeric($number)) {
        return false;
    }

    if (($number >= 0 && (int) $number < 0) || (int) $number < 0 - PHP_INT_MAX) {
        // overflow
        trigger_error(
            'convert_number_to_words s� aceita n�meros entre ' . PHP_INT_MAX . ' e ' . PHP_INT_MAX,
            E_USER_WARNING
        );
        return false;
    }

    if ($number < 0) {
        return $negative . convert_number_to_words(abs($number));
    }

    $string = $fraction = null;

    if (strpos($number, '.') !== false) {
        list($number, $fraction) = explode('.', $number);
    }

    switch (true) {
        case $number < 21:
            $string = $dictionary[$number];
            break;
        case $number < 100:
            $tens   = ((int) ($number / 10)) * 10;
            $units  = $number % 10;
            $string = $dictionary[$tens];
            if ($units) {
                $string .= $conjunction . $dictionary[$units];
            }
            break;
        case $number < 1000:
            $hundreds  = floor($number / 100)*100;
            $remainder = $number % 100;
            $string = $dictionary[$hundreds];
            if ($remainder) {
                $string .= $conjunction . convert_number_to_words($remainder);
            }
            break;
        default:
            $baseUnit = pow(1000, floor(log($number, 1000)));
            $numBaseUnits = (int) ($number / $baseUnit);
            $remainder = $number % $baseUnit;
            if ($baseUnit == 1000) {
                $string = convert_number_to_words($numBaseUnits) . ' ' . $dictionary[1000];
            } elseif ($numBaseUnits == 1) {
                $string = convert_number_to_words($numBaseUnits) . ' ' . $dictionary[$baseUnit][0];
            } else {
                $string = convert_number_to_words($numBaseUnits) . ' ' . $dictionary[$baseUnit][1];
            }
            if ($remainder) {
                $string .= $remainder < 100 ? $conjunction : $separator;
                $string .= convert_number_to_words($remainder);
            }
            break;
    }

    if (null !== $fraction && is_numeric($fraction)) {
        $string .= $decimal;
        $words = array();
        foreach (str_split((string) $fraction) as $number) {
            $words[] = $dictionary[$number];
        }
        $string .= implode(' ', $words);
    }

    return $string;
}
function ucwords2 ($string) {
    //as vers�es iniciais do PHP 5 n�o colocam caracteres acentuados em mai�scula
    $acento[0][0] = '�';
    $acento[0][1] = '�';
    $acento[1][0] = '�';
    $acento[1][1] = '�';
    $acento[2][0] = '�';
    $acento[2][1] = '�';
    $acento[3][0] = '�';
    $acento[3][1] = '�';
    $acento[4][0] = '�';
    $acento[4][1] = '�';
    $acento[5][0] = '�';
    $acento[5][1] = '�';
    $acento[6][0] = '�';
    $acento[6][1] = '�';
    $acento[7][0] = '�';
    $acento[7][1] = '�';
    $acento[8][0] = '�';
    $acento[8][1] = '�';
    $acento[9][0] = '�';
    $acento[9][1] = '�';
    $acento[10][0] = '�';
    $acento[10][1] = '�';
    $acento[11][0] = '�';
    $acento[11][1] = '�';
    $acento[12][0] = '�';
    $acento[12][1] = '�';
    $acento[13][0] = '�';
    $acento[13][1] = '�';
    $acento[14][0] = '�';
    $acento[14][1] = '�';
    $acento[15][0] = '�';
    $acento[15][1] = '�';
    $acento[16][0] = '�';
    $acento[16][1] = '�';
    $acento[17][0] = '�';
    $acento[17][1] = '�';
    $acento[18][0] = '�';
    $acento[18][1] = '�';
    $acento[19][0] = '�';
    $acento[19][1] = '�';
    $acento[20][0] = '�';
    $acento[20][1] = '�';
    $acento[21][0] = '�';
    $acento[21][1] = '�';
    $acento[22][0] = '�';
    $acento[22][1] = '�';

    $words = explode(' ', $string);

    foreach ($words as $index => $word)
    {
        $alterado=false;
        for($i=0;$i<23;$i++){
            if(substr($word, 0, 1)==$acento[$i][0]){
                $words[$index] = $acento[$i][1].substr($word, 1);
                $alterado=true;
            }
        }
        if(!$alterado){
            $words[$index] = strtoupper(substr($word, 0, 1)).substr($word, 1);
        }
    }

    $return_string = implode(' ', $words);

    return $return_string;
}
function numero_romano($numero) {
    if ($numero <= 0 || $numero > 3999) {
        return $numero;
    }

    $n = (int)$numero;
    $y = '';

    // Nivel 1
    while (($n / 1000) >= 1) {
        $y .= 'M';
        $n -= 1000;
    }
    if (($n / 900) >= 1) {
        $y .= 'CM';
        $n -= 900;
    }
    if (($n / 500) >= 1) {
        $y .= 'D';
        $n -= 500;
    }
    if (($n / 400) >= 1) {
        $y .= 'CD';
        $n -= 400;
    }

    // Nivel 2
    while (($n / 100) >= 1) {
        $y .= 'C';
        $n -= 100;
    }
    if (($n / 90) >= 1) {
        $y .= 'XC';
        $n -= 90;
    }
    if (($n / 50) >= 1) {
        $y .= 'L';
        $n -= 50;
    }
    if (($n / 40) >= 1) {
        $y .= 'XL';
        $n -= 40;
    }

    // Nivel 3
    while (($n / 10) >= 1) {
        $y .= 'X';
        $n -= 10;
    }
    if (($n / 9) >= 1) {
        $y .= 'IX';
        $n -= 9;
    }
    if (($n / 5) >= 1) {
        $y .= 'V';
        $n -= 5;
    }
    if (($n / 4) >= 1) {
        $y .= 'IV';
        $n -= 4;
    }

    // Nivel 4
    while ($n >= 1) {
        $y .= 'I';
        $n -= 1;
    }

    return $y;
}

function db_result($sql){
        $CI =& get_instance();
        $query = $CI -> db -> query($sql);
        $row = array_values($query -> row_array());
        return $row[0];
}

?>