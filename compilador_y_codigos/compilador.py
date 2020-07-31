import sys
import re

instr_categorias = {
    'sll': ['R1', '000000'],
    'srl': ['R1', '000010'],
    'sra': ['R1', '000011'],
    'sllv': ['R2', '000100'],
    'srlv': ['R2', '000110'],
    'srav': ['R2', '000111'],
    'addu': ['R3', '100001'],
    'subu': ['R3', '100011'], 
    'add': ['R3', '100000'], 
    'sub': ['R3', '100010'], 
    'and': ['R3', '100100'],
    'or': ['R3', '100101'],
    'xor': ['R3', '100110'],
    'nor': ['R3', '100111'],
    'slt': ['R3', '101010'],
    'lb': ['I1', '100000'],
    'lh': ['I1', '100001'],
    'lw': ['I1', '100011'],
    'lwu': ['I1', '100111'], 
    'lbu': ['I1', '100100'],
    'lhu': ['I1', '100101'],
    'sb': ['I1', '101000'],
    'sh': ['I1', '101001'],
    'sw': ['I1', '101011'],
    'addi': ['I2', '001000'],
    'andi': ['I2', '001100'],
    'ori': ['I2', '001101'],
    'xori': ['I2', '001110'],
    'slti': ['I2', '001010'],
    'lui': ['I3', '001111'],
    'beq': ['I4', '000100'],
    'bne': ['I4', '000101'],
    'j': ['I5', '000010'],
    'jal': ['I5', '000011'],
    'jr': ['J1', '001000'], 
    'jalr': ['J2', '001001'], 
    'halt': ['HALT', 'aaaaaaaa'],
    'nop': ['NOP', '00000000'],
}

instr_formatos = {
    'R1': r'(\w+)\sr(\d+),\sr(\d+),\s((?:0[xX])?[0-9a-fA-F]+)', # ej SLL rd, rt, sa
    'R2': r'(\w+)\sr(\d+),\sr(\d+),\sr(\d+)', # ej SLLV rd, rt, rs
    'R3': r'(\w+)\sr(\d+),\sr(\d+),\sr(\d+)', # ej AND rd, rs, rt
    'I1': r'(\w+)\sr(\d+),\s((?:0[xX])?[0-9a-fA-F]+)\(r(\d+)\)',# ej LW rt, offset(base) 
    'I2': r'(\w+)\sr(\d+),\sr(\d+),\s((?:0[xX])?[0-9a-fA-F]+)', # ej ADDI rt, rs, immediate 
    'I3': r'(\w+)\sr(\d+),\s((?:0[xX])?[0-9a-fA-F]+)', # ej LUI rt, immediate
    'I4': r'(\w+)\sr(\d+),\sr(\d+),\s((?:0[xX])?[0-9a-fA-F]+)', # ej BEQ rs, rt, offset
    'I5': r'([^\d]+)\s((?:0[xX])?[0-9a-fA-F]+)', # ej J target
    'J1': r'(\w+)\sr(\d+)', # ej JR rs
    'J2': r'(\w+)\sr(\d+),\sr(\d+)', # ej JALR rd, rs
    'HALT': r'(\bhalt\b)', # detencion del programa
    'NOP': r'(\bnop\b)' # burbuja
}


def assemble_line(instr_tipo, instr_codigo, mo):
    if instr_tipo == 'R1':
        rd = format(int(mo.group(2)), '05b')
        rt = format(int(mo.group(3)), '05b')
        sa = format(int(mo.group(4),0), '05b')
        assembled_line = '00000000000' + rt + rd + sa + instr_codigo
    elif instr_tipo == 'R2':
        rd = format(int(mo.group(2)), '05b')
        rt = format(int(mo.group(3)), '05b')
        rs = format(int(mo.group(4)), '05b')
        assembled_line = '000000' + rs + rt + rd + '00000' + instr_codigo
    elif instr_tipo == 'R3':
        rd = format(int(mo.group(2)), '05b')
        rs = format(int(mo.group(3)), '05b')
        rt = format(int(mo.group(4)), '05b')
        assembled_line = '000000' + rs + rt + rd + '00000' + instr_codigo
    elif instr_tipo == 'I1':
        rt = format(int(mo.group(2)), '05b')
        offset = format(int(mo.group(3),0), '016b')
        base = format(int(mo.group(4)), '05b')
        assembled_line = instr_codigo + base + rt + offset
    elif instr_tipo == 'I2':
        rt = format(int(mo.group(2)), '05b')
        rs = format(int(mo.group(3)), '05b')
        immediate = format(int(mo.group(4),0), '016b')
        assembled_line = instr_codigo + rs + rt + immediate
    elif instr_tipo == 'I3':
        rt = format(int(mo.group(2)), '05b')
        immediate = format(int(mo.group(3),0), '016b')
        assembled_line = instr_codigo + '00000' + rt + immediate
    elif instr_tipo == 'I4':
        rs = format(int(mo.group(2)), '05b')
        rt = format(int(mo.group(3)), '05b')
        offset = format(int(mo.group(4),0), '016b')
        assembled_line = instr_codigo + rs + rt + offset
    elif instr_tipo == 'I5':
        target = format(int(mo.group(2),0), '026b')
        assembled_line = instr_codigo + target
    elif instr_tipo == 'J1': #JR rs 
        rs = format(int(mo.group(2)), '05b')
        assembled_line = '000000'+ rs + '000000000000000'+ instr_codigo
    elif instr_tipo == 'J2': #JALR rd, rs 
        rd = format(int(mo.group(2)), '05b')
        rs = format(int(mo.group(3)), '05b')
        assembled_line = '000000'+ rs + '00000'+ rd + '00000'+ instr_codigo
    elif instr_tipo == 'HALT':
        output = format(int(instr_codigo,16), '032b')
        assembled_line = output
    elif instr_tipo == 'NOP':
        output = format(int(instr_codigo,16), '032b')
        assembled_line = output
    else:
        target = format(int(mo.group(2)), '026b')
        assembled_line = instr_codigo + target

    return assembled_line


## Funcion que se encarga de decodificar cada instrtruccion
def get_linea_binario(instr):
    if (instr=='halt'): instr= 'halt ' # se agrega espacio para que pueda ser tomado por los filtros de expresion de regular
    if (instr=='nop'): instr= 'nop ' # se agrega espacio para que pueda ser tomado por los filtros de expresion de regular
    instr_regex = re.compile(r'([^\d]+)\s')  # me quedo con la primera parte de la instrtruccion (and, andi, add..)
    mo = instr_regex.search(instr) # 

    instr_datos = instr_categorias[mo.group(1)] # se busca coincidencia en el diccionario instr_categorias usando como indice la primera parte de la instrtruccion

    instr_tipo = instr_datos[0]
    instr_codigo = instr_datos[1]
    filtro_regex = instr_formatos[instr_tipo]

    instr_tipo_regex = re.compile(filtro_regex)
    mo = instr_tipo_regex.search(instr)

    return assemble_line(instr_tipo, instr_codigo, mo)


if __name__ == '__main__':
    
    input_program = 'Entrada_ASM.txt'
    output_program = 'Salida_HEX.txt'
    try:
        f = open(input_program, 'r')
    except Exception as e:
        print('Programa no encontrado')
        quit()

    instrtrucciones = f.readlines()
    f.close()

    try:
        f = open(output_program, 'w')
    except Exception as e:
        print('El archivo de salida no pudo ser creado')
        quit()


    for instrtruccion in instrtrucciones:
        linea_binario = get_linea_binario(instrtruccion.lower())
        
        if(instrtruccion.lower()!='halt'): 
            linea_hexa = format(int(linea_binario, 2), '08X') + '\n' # se convierte de binario a hexa
        else:
            linea_hexa = format(int(linea_binario, 2), '08X') # se elimina el ultimo salto de linea
        f.write(linea_hexa)
        
        print(instrtruccion + ' ' + linea_hexa)

    f.close()
