#!/usr/bin/env node

const https = require('https');

const DEPLOYMENT_URL = 'https://fodd-innovv-i490bl3hj-fridaytodaygo-gmailcoms-projects.vercel.app';

console.log('🔍 Verifying F&B Innovation Platform Deployment...\n');

const testEndpoint = (path, description) => {
  return new Promise((resolve) => {
    const url = `${DEPLOYMENT_URL}${path}`;
    console.log(`Testing ${description}: ${url}`);
    
    https.get(url, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        const status = res.statusCode;
        const success = status >= 200 && status < 300;
        console.log(`  ${success ? '✅' : '❌'} Status: ${status}`);
        
        if (success && path.includes('/api/')) {
          try {
            const json = JSON.parse(data);
            console.log(`  📄 Response: ${JSON.stringify(json).substring(0, 100)}...`);
          } catch (e) {
            console.log(`  📄 Response: ${data.substring(0, 100)}...`);
          }
        }
        console.log('');
        resolve({ success, status, data });
      });
    }).on('error', (err) => {
      console.log(`  ❌ Error: ${err.message}\n`);
      resolve({ success: false, error: err.message });
    });
  });
};

async function verifyDeployment() {
  const tests = [
    { path: '/api/health', desc: 'API Health Check' },
    { path: '/api/menu', desc: 'Menu API' },
    { path: '/api/analytics/dashboard/demo', desc: 'Analytics API' },
    { path: '/', desc: 'Frontend Homepage' }
  ];

  console.log('Running deployment verification tests...\n');
  
  const results = [];
  for (const test of tests) {
    const result = await testEndpoint(test.path, test.desc);
    results.push({ ...test, ...result });
  }

  console.log('📊 DEPLOYMENT VERIFICATION SUMMARY');
  console.log('='.repeat(50));
  
  let allPassed = true;
  results.forEach(result => {
    const status = result.success ? '✅ PASS' : '❌ FAIL';
    console.log(`${status} ${result.desc}`);
    if (!result.success) allPassed = false;
  });

  console.log('='.repeat(50));
  
  if (allPassed) {
    console.log('🎉 ALL TESTS PASSED! Your F&B Innovation Platform is working correctly.');
    console.log('\n🚀 Available Features:');
    console.log('   • Interactive Menu System');
    console.log('   • Shopping Cart & Checkout');
    console.log('   • Analytics Dashboard');
    console.log('   • Order Management');
    console.log('   • Mobile Responsive Design');
  } else {
    console.log('⚠️  Some tests failed. Check the errors above.');
    console.log('\n🔧 Troubleshooting:');
    console.log('   1. Redeploy: vercel --prod --force');
    console.log('   2. Check Vercel build logs');
    console.log('   3. Verify all files are committed');
  }

  console.log(`\n🔗 Your deployment: ${DEPLOYMENT_URL}`);
}

verifyDeployment().catch(console.error);