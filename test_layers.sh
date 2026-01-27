#!/bin/bash
# Test script to verify obfuscation layers work

echo "🧪 Testing Obfuscation Framework Layers"
echo "========================================"

# Test 1: Basic encoding/decoding
echo ""
echo "🔬 Test 1: Basic Layer Testing"
echo "------------------------------"

# Test Unicode layer
python3 -c "
from obfuscators.unicode import UnicodeObfuscator
u = UnicodeObfuscator()
encoded = u.encode('whoami')
print(f'Unicode: whoami -> {repr(encoded)}')
"

# Test Base64 layer
python3 -c "
from encoders.base64 import Base64Encoder
b = Base64Encoder()
encoded = b.encode('whoami')
print(f'Base64: whoami -> {encoded}')
"

# Test XOR layer
python3 -c "
from encoders.xor import XOREncoder
x = XOREncoder()
encoded = x.encode('whoami')
print(f'XOR: whoami -> {repr(encoded)}')
"

# Test 2: Full chain for Linux
echo ""
echo "🔬 Test 2: Linux Chain (stealth)"
echo "--------------------------------"
python3 main.py --file sample_payloads/basic.txt --chain stealth --target linux --variants 1 | grep -A5 "Ready for deployment:"

# Test 3: Full chain for Windows  
echo ""
echo "🔬 Test 3: Windows Chain (stealth)"
echo "----------------------------------"
python3 main.py --file sample_payloads/basic.txt --chain stealth --target windows --variants 1 | grep -A5 "Ready for deployment:"

# Test 4: Decoder test
echo ""
echo "🔬 Test 4: Decoder Test"
echo "----------------------"
if [ -f "encoded_payload_*.txt" ]; then
    latest_file=$(ls -t encoded_payload_*.txt | head -1)
    echo "Testing decoder on: $latest_file"
    python3 decoder.py "$latest_file"
else
    echo "No encoded payload files found. Generate one first."
fi

# Test 5: Library compilation
echo ""
echo "🔬 Test 5: Library Check"
echo "-----------------------"
if [ -f "libhook.so" ]; then
    echo "✅ libhook.so exists"
    file libhook.so
    ldd libhook.so 2>/dev/null || echo "Library dependencies check failed"
else
    echo "❌ libhook.so missing"
fi

echo ""
echo "🎯 Testing Complete!"