// SPDX-License-Identifier: MIT


pragma solidity ^0.8.10;


contract Escuela {

    //Programar un Smart Contract Estudiante.sol que incluya:
    
    string private nombre;      //La variable privada string nombre.

    string private _apellido;    //La variable privada string apellido.

    string private _curso;       //La variable privada string curso.

    address private docente;    //La variable privada address docente.

    mapping (string => uint8) private notas_materia_s;    //La variable privada mapping(string => T) notas_materias.

    string[] private nombre_materia_s;


    //Un constructor que tome nombre, apellido y curso y los asigne dentro del
    //smart contract, a su vez debe asignar a la variable docente el address de quien
    //llamó a la función.
    constructor(string memory nombre_, string memory apellido_, string memory curso_) {
        nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        docente = msg.sender;
    }


    //apellido() devuelve el apellido del estudiante como string.
    function apellido() public view returns (string memory)
    {
        return _apellido;
    }


    //nombre_completo() devuelve el nombre y el apellido del estudiante como string.
    function nombre_completo() public view returns (string memory) {
        return string(abi.encodePacked(nombre, " " , _apellido)); //abi.encodePacked lo que hace es como concatenar strings, osea, te los junta.
    }


    //curso() devuelve el curso del alumno como string.
    function curso() public view returns(string memory)
    {
        return _curso;
    }

    function set_nota_materia(uint8 nota, string memory materia) public
    {
        //Permite que la nota solamente pueda ser hacer cambios en la nota, si es otra persona la que lo quiere cambiar, le tira ese hermoso y carinioso mensaje al alumno.
        require(docente == msg.sender , "Chanta, solo lo puede cambiar el profe, no vos. SANCION!"); 

        //La nota se recibe como un entero del 1 al 100.
        require(nota <=100 && nota >= 1, "Tiene que ingresar un numero entre 1 y 100"); 

        notas_materia_s[materia] = nota;

        nombre_materia_s.push(materia); 

    }

    //nota_materia(string memory materia) devuelve la nota del Estudiante dada una materia.
    function nota_materia(string memory materia) public view returns (uint) {
        uint nota = notas_materia_s[materia];   
        return nota;
    }


    // Es un if, que comprueba que la nota sea mayor a 60, y si es así, devuelve true, y si no es mayor a 60 te devuelve false.
    function aprobo(string memory materia) public view returns (bool) {
        if (notas_materia_s[materia] >= 60)
        {
            return true;
        } 
        else 
        {
            return false;
        }
       
    }


    //promedio() devuelve un entero con el promedio del alumno.
    function promedio() public view returns (uint) {

        uint cantidad_mat = nombre_materia_s.length;
        uint _notaParaPromedio;
        uint notaFinal;

        for (uint i = 0; i < cantidad_mat; i++){
            _notaParaPromedio += notas_materia_s[nombre_materia_s[i]];
        }

        notaFinal = _notaParaPromedio / cantidad_mat;
        return notaFinal;
    
    }












}
