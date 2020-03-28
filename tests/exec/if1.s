	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq $65, -8(%rbp)
	movq -8(%rbp), %rdi
	call putchar
	movq -8(%rbp), %rax
	cmpq $0, %rax
	jz L42
	movq $66, -8(%rbp)
L42:
	movq -8(%rbp), %rdi
	call putchar
	movq -8(%rbp), %rax
	cmpq $0, %rax
	jz L33
	movq $0, %rdi
	cmpq $0, %rdi
	jz L33
	movq $67, -8(%rbp)
	movq -8(%rbp), %rdi
L33:
	movq -8(%rbp), %rdi
	call putchar
	movq -8(%rbp), %rax
	cmpq $0, %rax
	jz L24
	movq $1, %rdi
	cmpq $0, %rdi
	jz L24
	movq $68, -8(%rbp)
	movq -8(%rbp), %rdi
L24:
	movq -8(%rbp), %rdi
	call putchar
	movq -8(%rbp), %rax
	cmpq $0, %rax
	jz L20
L18:
	movq $69, %rdi
	movq %rdi, -8(%rbp)
	movq -8(%rbp), %rdi
L15:
	movq -8(%rbp), %rdi
	call putchar
	movq -8(%rbp), %rax
	cmpq $0, %rax
	jz L11
L9:
	movq $70, %rdi
	movq %rdi, -8(%rbp)
	movq -8(%rbp), %rdi
L6:
	movq -8(%rbp), %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
L11:
	movq $1, %rdi
	testq $0, %rdi
	jz L6
	jmp L9
L20:
	movq $0, %rdi
	testq $0, %rdi
	jz L15
	jmp L18
	jmp L24
	jmp L24
	jmp L33
	jmp L33
	jmp L42
	.data
