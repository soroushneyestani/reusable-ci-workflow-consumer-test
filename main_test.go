package main

import "testing"

func TestGreeting(t *testing.T) {
	const want = "deliberate synthetic test mismatch"
	if got := greeting(); got != want {
		t.Fatalf("greeting() = %q, want %q", got, want)
	}
}
