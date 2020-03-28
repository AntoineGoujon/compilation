	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq $10, %rbx
	movq %rbx, %rdi
L19:
	movq $0, %rdi
	movq %rbx, %rcx
	cmpq %rdi, %rcx
	setg %cl
	movzbq %cl, %rcx
	cmpq $0, %rcx
	jz L4
	movq $1, %rcx
	movq $1, %rdi
	movq %rbx, %rsi
	subq %rdi, %rsi
	movq %rsi, %rbx
	movq %rbx, %rsi
	movq $65, %rdi
	addq %rsi, %rdi
	addq %rcx, %rdi
	call putchar
	jmp L19
L4:
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
