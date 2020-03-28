	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $0, %rdi
	cmpq $0, %rdi
	jz L35
	movq $1, %rdi
	cmpq $0, %rdi
	jz L35
	movq $1, %rcx
L34:
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $0, %rax
	cmpq $0, %rax
	jz L26
	movq $2, %rdi
	cmpq $0, %rdi
	jz L26
	movq $1, %rcx
L25:
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $1, %rax
	cmpq $0, %rax
	jz L17
	movq $0, %rdi
	cmpq $0, %rdi
	jz L17
	movq $1, %rcx
L16:
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $0, %rax
	cmpq $0, %rax
	jz L8
	movq $0, %rdi
	cmpq $0, %rdi
	jz L8
	movq $1, %rcx
L7:
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
L8:
	movq $0, %rcx
	jmp L7
	jmp L8
L17:
	movq $0, %rcx
	jmp L16
	jmp L17
L26:
	movq $0, %rcx
	jmp L25
	jmp L26
L35:
	movq $0, %rcx
	jmp L34
	jmp L35
	.data
