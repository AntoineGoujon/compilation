	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $0, %rsi
	movq %rsi, %rax
	movq $0, %rax
	movq %rax, %rdi
L37:
	movq $10, %rdi
	movq %rax, %rdx
	cmpq %rdi, %rdx
	jl L34
	movq $100, %rax
	cmpq %rax, %rsi
	sete %sil
	movzbq %sil, %rsi
	cmpq $0, %rsi
	jz L4
	movq $33, %rdi
	call putchar
L4:
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	jmp L4
L34:
	movq $10, %rdx
	movq %rdx, %rcx
L31:
	movq $0, %rcx
	movq %rdx, %rdi
	cmpq %rcx, %rdi
	setg %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L16
	movq $1, %rdi
	addq %rdi, %rsi
	movq %rsi, %rdi
	movq $1, %rdi
	subq %rdi, %rdx
	jmp L31
L16:
	movq $1, %rdx
	addq %rdx, %rax
	jmp L37
	.data
