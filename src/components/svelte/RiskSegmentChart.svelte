<script>
  import { onMount } from 'svelte';

  export let companyData = {
    name: "Sample Startup",
    industry: "Software",
    size: "25-50 employees",
    dataSensitivity: "Medium",
    securityMaturity: "Developing"
  };

  export let riskScores = {
    dataBreachRisk: 65,
    ransomwareExposure: 48,
    vendorRisk: 72,
    employeeSecurityRisk: 54,
    cloudSecurityRisk: 58
  };

  // Removed the unnecessary mounted variable
  
  onMount(() => {
    // This ensures the component is properly initialized on the client
    console.log('Risk Segment Chart component mounted');
  });

  function getColorClass(score) {
    if (score >= 75) return "bg-red-500";
    if (score >= 50) return "bg-yellow-500";
    return "bg-green-500";
  }
</script>

<div class="bg-white p-6 rounded-lg shadow-md">
  <h3 class="text-lg font-semibold mb-4">Risk Segmentation for {companyData.name}</h3>
  <div class="mb-4">
    <span class="text-sm text-gray-500">Industry: {companyData.industry}</span>
    <span class="text-sm text-gray-500 ml-4">Size: {companyData.size}</span>
  </div>

  <div class="space-y-4">
    {#each Object.entries(riskScores) as [riskType, score]}
      <div class="mb-2">
        <div class="flex justify-between mb-1">
          <span class="text-sm font-medium">{riskType.replace(/([A-Z])/g, ' $1').replace(/^./, (str) => str.toUpperCase())}</span>
          <span class="text-sm font-medium">{score}%</span>
        </div>
        <div class="w-full bg-gray-200 rounded-full h-2.5">
          <div class={`h-2.5 rounded-full ${getColorClass(score)}`} style="width: {score}%"></div>
        </div>
      </div>
    {/each}
  </div>

  <div class="mt-6 pt-4 border-t border-gray-200">
    <h4 class="text-md font-medium mb-2">Risk Assessment Summary</h4>
    <p class="text-sm text-gray-600">
      Based on your company profile, your organization has moderate to high risk in vendor management and data breach vulnerabilities.
      Consider implementing stronger vendor security assessments and data protection measures.
    </p>
  </div>
</div>