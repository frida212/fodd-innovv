#!/usr/bin/env node

// Quick deployment status check
const https = require('https');

const BASE_URL = 'https://fodd-innovv-i490bl3hj-fridaytodaygo-gmailcoms-projects.vercel.app';

console.log('🔍 Checking F&B Innovation Platform Deployment Status...\n');

// Test API Health
https.get(`${BASE_URL}/api/health`, (res) => {
  let data = '';
  res.on('data', chunk => data += chunk);
  res.on('end', () => {
    console.log(`🔧 API Status: ${res.statusCode}`);
    if (res.statusCode === 200) {
      try {
        const json = JSON.parse(data);
        console.log('✅ API is working!');
        console.log(`📊 Response: ${json.message || json.status}`);
      } catch (e) {
        console.log('✅ API responded but with non-JSON data');
      }
    } else {
      console.log('❌ API not responding correctly');
    }
    
    // Test Frontend
    console.log('\n🌐 Testing Frontend...');
    https.get(BASE_URL, (res2) => {
      console.log(`🔧 Frontend Status: ${res2.statusCode}`);
      if (res2.statusCode === 200) {
        console.log('✅ Frontend is loading!');
        console.log('\n🎉 SUCCESS! Your F&B Innovation Platform is LIVE!');
        console.log('\n🚀 Available Features:');
        console.log('   • Interactive Menu System');
        console.log('   • Shopping Cart & Checkout');
        console.log('   • Analytics Dashboard');
        console.log('   • Order Management');
        console.log('\n🔗 Visit your app: ' + BASE_URL);
      } else if (res2.statusCode === 404) {
        console.log('❌ Frontend showing 404 - still building or routing issue');
        console.log('\n🔧 Try: vercel --prod --force');
      } else {
        console.log(`❌ Frontend status: ${res2.statusCode}`);
      }
    }).on('error', (err) => {
      console.log('❌ Frontend connection error:', err.message);
    });
  });
}).on('error', (err) => {
  console.log('❌ API connection error:', err.message);
  console.log('\n🔧 The deployment might still be building...');
  console.log('   Wait a few minutes and try again');
});

console.log('⏳ Testing endpoints...');