	.text
	.globl main
f:
	pushq %rbp
	movq %rsp, %rbp
	movq $2, %rcx
	imulq %rsi, %rcx
	addq %rcx, %rdi
	movq %rdi, %rax
	popq %rbp
	ret
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $0, %rsi
	movq $65, %rdi
	call f
	movq %rax, %rdi
	call putchar
	movq %rax, %rsi
	movq $1, %rsi
	movq $65, %rdi
	call f
	movq %rax, %rdi
	call putchar
	movq %rax, %rsi
	movq $2, %rsi
	movq $65, %rdi
	call f
	movq %rax, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	.data
