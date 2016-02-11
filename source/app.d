immutable long osize = 0x1000;
immutable long ocount = 0x10000;

class A {
	int[osize] stuff;
}

struct B {
	int[osize] stuff;
}

static import core.memory;

void makeClasses() {
	A[] as = new A[ocount];
	assert(as!=null);
	as[0..$] = new A();
	as[ocount-1].stuff[osize-1] = 42;
	foreach(a;as) {
		destroy(a);
		core.memory.GC.free(cast(void*)(a));
	}
	destroy(as);
	core.memory.GC.free(cast(void*)(as));
}

void makeStructs() {
	B[] bs;
	bs.length = ocount;
	bs[ocount-1].stuff[osize-1] = 42;
}

import std.datetime: benchmark;
import std.stdio;

void main()
{
	auto r = benchmark!(makeClasses,makeStructs)(1);
	writeln(cast(float)(r[1].length) / r[0].length);
	writeln("Edit source/app.d to start your project.");
}
