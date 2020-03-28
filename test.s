	.text
	.globl main
add:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %rdx
	movq %rsi, %rcx
	movq %rdi, %rsi
	movq %rcx, %rdi
	movq %rsi, %rcx
	addq %rdi, %rcx
	movq %rcx, %rax
	movq %rdx, %r12
	movq %rbp, %rsp
	popq %rbp
	ret
div:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %r8
	movq %rsi, %rcx
	movq $8192, %rsi
	imulq %rsi, %rdi
	movq %rdi, %rsi
	movq %rsi, %r12
	movq %rcx, %r12
	movq $2, %r9
	movq %rcx, %rdi
	movq %rdi, %rax
	cqto
	idivq %r9
	movq %rax, %rdi
	movq %rsi, %rcx
	addq %rdi, %rcx
	movq %rcx, %rax
	cqto
	idivq %r12
	movq %rax, %rcx
	movq %rcx, %rax
	movq %r8, %r12
	movq %rbp, %rsp
	popq %rbp
	ret
sub:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %rdx
	movq %rsi, %rcx
	subq %rcx, %rdi
	movq %rdi, %rax
	movq %rdx, %r12
	movq %rbp, %rsp
	popq %rbp
	ret
of_int:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %rsi
	movq %rbx, %rcx
	movq $8192, %rbx
	imulq %rbx, %rdi
	movq %rdi, %rax
	movq %rsi, %r12
	movq %rcx, %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
mul:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %rcx
	imulq %rsi, %rdi
	movq %rdi, %rsi
	movq $8192, %rsi
	movq $4096, %rax
	addq %rax, %rdi
	movq %rdi, %rax
	cqto
	idivq %rsi
	movq %rax, %rdi
	movq %rdi, %rax
	movq %rcx, %r12
	movq %rbp, %rsp
	popq %rbp
	ret
iter:
	pushq %rbp
	movq %rsp, %rbp
	addq $-96, %rsp
	movq %r8, -56(%rbp)
	movq %rcx, -48(%rbp)
	movq %rdx, -40(%rbp)
	movq %rsi, -24(%rbp)
	movq %rdi, -16(%rbp)
L78:
	movq $100, %rcx
	movq -16(%rbp), %rdi
	cmpq %rcx, %rdi
	sete %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L73
	movq $1, %rdi
L37:
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
L73:
	movq -48(%rbp), %rcx
	movq -48(%rbp), %rdi
	movq %rcx, %rsi
	call mul
	movq %rax, %rdi
	movq %rdi, -72(%rbp)
	movq -72(%rbp), %rcx
	movq -56(%rbp), %rcx
	movq -56(%rbp), %rdi
	movq %rcx, %rsi
	call mul
	movq %rax, %rdi
	movq %rdi, -64(%rbp)
	movq -64(%rbp), %rdi
	movq $4, %rdi
	call of_int
	movq %rax, -32(%rbp)
	movq -64(%rbp), %rcx
	movq -72(%rbp), %rdi
	movq %rcx, %rsi
	call add
	movq %rax, %rdi
	cmpq -32(%rbp), %rdi
	setg %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L55
	movq $0, %rdi
	jmp L37
L55:
	movq -40(%rbp), %r15
	movq %r15, -8(%rbp)
	movq -56(%rbp), %rcx
	movq -48(%rbp), %rdi
	movq %rcx, %rsi
	call mul
	movq %rax, -96(%rbp)
	movq $2, %rdi
	call of_int
	movq %rax, %rdi
	movq -96(%rbp), %rsi
	call mul
	movq %rax, %rdi
	movq -8(%rbp), %rsi
	call add
	movq %rax, -88(%rbp)
	movq -24(%rbp), %r15
	movq %r15, -80(%rbp)
	movq -64(%rbp), %rcx
	movq -72(%rbp), %rdi
	movq %rcx, %rsi
	call sub
	movq %rax, %rdi
	movq -80(%rbp), %rsi
	call add
	movq %rax, %rdi
	movq -40(%rbp), %rdx
	movq -24(%rbp), %rsi
	movq -16(%rbp), %rcx
	addq $1, %rcx
	movq -88(%rbp), %r15
	movq %r15, -56(%rbp)
	movq %rdi, -48(%rbp)
	movq %rdx, -40(%rbp)
	movq %rsi, -24(%rbp)
	movq %rcx, -16(%rbp)
	jmp L78
run:
	pushq %rbp
	movq %rsp, %rbp
	addq $-104, %rsp
	movq %rdi, -16(%rbp)
	movq $2, %rcx
	movq $0, %rdi
	subq %rcx, %rdi
	call of_int
	movq %rax, %rdi
	movq %rdi, -72(%rbp)
	movq -72(%rbp), %rdi
	movq $1, %rdi
	call of_int
	movq %rax, %rdi
	movq %rdi, -64(%rbp)
	movq -64(%rbp), %rcx
	movq -16(%rbp), %rcx
	movq $2, %rdi
	imulq %rcx, %rdi
	call of_int
	movq %rax, -8(%rbp)
	movq -72(%rbp), %rcx
	movq -64(%rbp), %rdi
	movq %rcx, %rsi
	call sub
	movq %rax, %rdi
	movq -8(%rbp), %rsi
	call div
	movq %rax, %rdi
	movq %rdi, -56(%rbp)
	movq -56(%rbp), %rcx
	movq $1, %rcx
	movq $0, %rdi
	subq %rcx, %rdi
	call of_int
	movq %rax, %rdi
	movq %rdi, -48(%rbp)
	movq -48(%rbp), %rdi
	movq $1, %rdi
	call of_int
	movq %rax, %rdi
	movq %rdi, -40(%rbp)
	movq -40(%rbp), %rdi
	movq -16(%rbp), %rdi
	call of_int
	movq %rax, -104(%rbp)
	movq -48(%rbp), %rcx
	movq -40(%rbp), %rdi
	movq %rcx, %rsi
	call sub
	movq %rax, %rdi
	movq -104(%rbp), %rsi
	call div
	movq %rax, %rdi
	movq %rdi, -32(%rbp)
	movq -32(%rbp), %rdi
	movq $0, %rdi
	movq %rdi, -24(%rbp)
	movq -24(%rbp), %rdi
L117:
	movq -16(%rbp), %rdi
	movq -24(%rbp), %r15
	movq %r15, -96(%rbp)
	cmpq %rdi, -96(%rbp)
	jl L114
	movq $0, %rdi
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
L114:
	movq -32(%rbp), %r15
	movq %r15, -96(%rbp)
	movq -24(%rbp), %rdi
	call of_int
	movq %rax, %rdi
	movq -96(%rbp), %rsi
	call mul
	movq %rax, %rcx
	movq -48(%rbp), %rdi
	movq %rcx, %rsi
	call add
	movq %rax, %rdi
	movq $0, %rdi
	movq %rdi, -80(%rbp)
	movq -80(%rbp), %rcx
L103:
	movq -16(%rbp), %rcx
	movq $2, %rdi
	imulq %rcx, %rdi
	movq -80(%rbp), %r15
	movq %r15, -88(%rbp)
	cmpq %rdi, -88(%rbp)
	jl L98
	movq -24(%rbp), %rdi
	addq $1, %rdi
	movq %rdi, -24(%rbp)
	movq -24(%rbp), %rdi
	jmp L117
L98:
	movq -56(%rbp), %r15
	movq %r15, -88(%rbp)
	movq -80(%rbp), %rdi
	call of_int
	movq %rax, %rdi
	movq -88(%rbp), %rsi
	call mul
	movq %rax, %rcx
	movq -72(%rbp), %rdi
	movq %rcx, %rsi
	call add
	movq %rax, %rdi
	movq -80(%rbp), %rdi
	addq $1, %rdi
	movq %rdi, -80(%rbp)
	movq -80(%rbp), %rdi
	jmp L103
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq $10000, %rdi
	movq %rdi, -8(%rbp)
	movq -8(%rbp), %rcx
L171:
	movq $0, %rcx
	movq -8(%rbp), %rdi
	cmpq %rcx, %rdi
	setg %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L160
	movq $30, %rdi
	call run
	movq %rax, %rdi
	movq -8(%rbp), %rdi
	addq $-1, %rdi
	movq %rdi, -8(%rbp)
	movq -8(%rbp), %rdi
	jmp L171
L160:
	movq $0, %rdi
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
inside:
	pushq %rbp
	movq %rsp, %rbp
	addq $-24, %rsp
	movq %rsi, -24(%rbp)
	movq %rdi, -16(%rbp)
	movq $0, %rdi
	call of_int
	movq %rax, -8(%rbp)
	movq $0, %rdi
	call of_int
	movq %rax, %rcx
	movq -24(%rbp), %rdx
	movq -16(%rbp), %rsi
	movq $0, %rdi
	movq -8(%rbp), %r8
	call iter
	movq %rax, %rdi
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
