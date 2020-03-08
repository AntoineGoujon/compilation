	.text
	.globl main
f:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %rsi
	movq %rbx, %rcx
	movq $1, %rdi
	movq %rdi, %rax
	movq %rsi, %r12
	movq %rcx, %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq $2, %rdi
	call f
	movq %rax, %rdi
	movq $0, %rdi
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
