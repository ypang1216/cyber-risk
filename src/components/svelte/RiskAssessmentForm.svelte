<script>
  import { onMount } from 'svelte';
  
  let formData = {
    companyName: "",
    industry: "Software",
    employeeCount: "1-10",
    annualRevenue: "Under $1M",
    dataTypes: [],
    securityMeasures: [],
    incidentHistory: "No"
  };
  
  let industries = [
    "Software", 
    "Finance/Banking", 
    "Healthcare", 
    "E-commerce/Retail", 
    "Manufacturing",
    "Professional Services",
    "Education",
    "Media/Entertainment",
    "Telecommunications",
    "Other"
  ];
  
  let employeeRanges = [
    "1-10", 
    "11-25", 
    "26-50", 
    "51-100", 
    "101-250", 
    "251-500", 
    "501-1000", 
    "1000+"
  ];
  
  let revenueRanges = [
    "Under $1M", 
    "$1M - $5M", 
    "$5M - $10M", 
    "$10M - $25M", 
    "$25M - $50M", 
    "$50M - $100M", 
    "$100M+"
  ];
  
  let dataTypeOptions = [
    { id: "pii", label: "Personal Identifiable Information (PII)" },
    { id: "health", label: "Healthcare Data (PHI)" },
    { id: "payment", label: "Payment/Financial Data" },
    { id: "intellectual", label: "Intellectual Property" },
    { id: "business", label: "Business Confidential Information" }
  ];
  
  let securityOptions = [
    { id: "mfa", label: "Multi-Factor Authentication" },
    { id: "encryption", label: "Data Encryption at Rest" },
    { id: "training", label: "Regular Security Training" },
    { id: "backups", label: "Offsite Backups" },
    { id: "incident", label: "Incident Response Plan" },
    { id: "vendor", label: "Vendor Security Assessment Process" }
  ];
  
  let isSubmitted = false;
  let isLoading = false;
  
  function handleDataTypeChange(id) {
    if (formData.dataTypes.includes(id)) {
      formData.dataTypes = formData.dataTypes.filter(item => item !== id);
    } else {
      formData.dataTypes = [...formData.dataTypes, id];
    }
  }
  
  function handleSecurityChange(id) {
    if (formData.securityMeasures.includes(id)) {
      formData.securityMeasures = formData.securityMeasures.filter(item => item !== id);
    } else {
      formData.securityMeasures = [...formData.securityMeasures, id];
    }
  }
  
  function handleSubmit() {
    isLoading = true;
    
    // Simulate API call delay
    setTimeout(() => {
      isSubmitted = true;
      isLoading = false;
    }, 1500);
  }
  
  function calculateRiskScore() {
    // Simple risk score calculation simulation
    // In a real app, this would be a much more sophisticated algorithm
    
    let baseScore = 50; // Start with a neutral score
    
    // Industry factor
    const industryFactor = {
      "Software": 5,
      "Finance/Banking": 10,
      "Healthcare": 15,
      "E-commerce/Retail": 8,
      "Manufacturing": 3,
      "Professional Services": 5,
      "Education": 7,
      "Media/Entertainment": 4,
      "Telecommunications": 6,
      "Other": 5
    };
    
    // Company size factor
    const sizeFactor = {
      "1-10": 0,
      "11-25": 2,
      "26-50": 4,
      "51-100": 6,
      "101-250": 8,
      "251-500": 10,
      "501-1000": 12,
      "1000+": 15
    };
    
    // Add industry risk
    baseScore += industryFactor[formData.industry];
    
    // Add size risk
    baseScore += sizeFactor[formData.employeeCount];
    
    // Add data type risk
    baseScore += formData.dataTypes.length * 3;
    
    // Reduce risk based on security measures
    baseScore -= formData.securityMeasures.length * 4;
    
    // Previous incidents increase risk
    if (formData.incidentHistory === "Yes") {
      baseScore += 15;
    }
    
    // Ensure the score stays within 0-100
    return Math.max(0, Math.min(100, baseScore));
  }
</script>

<div class="bg-white rounded-lg shadow-md p-6">
  <h2 class="text-xl font-bold mb-6">Company Risk Assessment</h2>
  
  {#if !isSubmitted}
    <form on:submit|preventDefault={handleSubmit} class="space-y-6">
      <div>
        <label for="companyName" class="block text-sm font-medium text-gray-700 mb-1">Company Name</label>
        <input 
          type="text" 
          id="companyName" 
          bind:value={formData.companyName} 
          required
          class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
      </div>
      
      <div>
        <label for="industry" class="block text-sm font-medium text-gray-700 mb-1">Industry</label>
        <select 
          id="industry" 
          bind:value={formData.industry} 
          class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        >
          {#each industries as industry}
            <option value={industry}>{industry}</option>
          {/each}
        </select>
      </div>
      
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div>
          <label for="employeeCount" class="block text-sm font-medium text-gray-700 mb-1">Number of Employees</label>
          <select 
            id="employeeCount" 
            bind:value={formData.employeeCount} 
            class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
          >
            {#each employeeRanges as range}
              <option value={range}>{range}</option>
            {/each}
          </select>
        </div>
        <div>
          <label for="annualRevenue" class="block text-sm font-medium text-gray-700 mb-1">Annual Revenue</label>
          <select 
            id="annualRevenue" 
            bind:value={formData.annualRevenue}
            class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
          >
            {#each revenueRanges as range}
              <option value={range}>{range}</option>
            {/each}
          </select>
        </div>
      </div>
      
      <div>
        <span class="block text-sm font-medium text-gray-700 mb-2">Types of Data Handled (Select all that apply)</span>
        <div class="space-y-2">
          {#each dataTypeOptions as option}
            <div class="flex items-start">
              <input
                type="checkbox"
                id={option.id}
                checked={formData.dataTypes.includes(option.id)}
                on:change={() => handleDataTypeChange(option.id)}
                class="mt-0.5 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
              />
              <label for={option.id} class="ml-2 text-sm text-gray-700">{option.label}</label>
            </div>
          {/each}
        </div>
      </div>
      
      <div>
        <span class="block text-sm font-medium text-gray-700 mb-2">Security Measures in Place (Select all that apply)</span>
        <div class="space-y-2">
          {#each securityOptions as option}
            <div class="flex items-start">
              <input
                type="checkbox"
                id={option.id}
                checked={formData.securityMeasures.includes(option.id)}
                on:change={() => handleSecurityChange(option.id)}
                class="mt-0.5 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
              />
              <label for={option.id} class="ml-2 text-sm text-gray-700">{option.label}</label>
            </div>
          {/each}
        </div>
      </div>
      
      <div>
        <span class="block text-sm font-medium text-gray-700 mb-2">Has your company experienced a cybersecurity incident in the past 24 months?</span>
        <div class="flex space-x-4">
          <div class="flex items-center">
            <input 
              type="radio" 
              id="incident-yes" 
              value="Yes" 
              bind:group={formData.incidentHistory}
              class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300"
            />
            <label for="incident-yes" class="ml-2 text-sm text-gray-700">Yes</label>
          </div>
          <div class="flex items-center">
            <input 
              type="radio" 
              id="incident-no" 
              value="No" 
              bind:group={formData.incidentHistory}
              class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300"
            />
            <label for="incident-no" class="ml-2 text-sm text-gray-700">No</label>
          </div>
        </div>
      </div>
      
      <div class="pt-2">
        <button 
          type="submit" 
          class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
          disabled={isLoading}
        >
          {#if isLoading}
            <span>Processing...</span>
          {:else}
            <span>Calculate Risk Profile</span>
          {/if}
        </button>
      </div>
    </form>
  {:else}
    <!-- Results display -->
    <div class="space-y-6">
      <h3 class="text-lg font-semibold">Risk Assessment Results for {formData.companyName}</h3>
      
      <div>
        <h4 class="font-medium mb-2">Company Profile</h4>
        <div class="grid grid-cols-2 gap-x-4 gap-y-2 text-sm">
          <div>Industry:</div>
          <div class="font-medium">{formData.industry}</div>
          
          <div>Size:</div>
          <div class="font-medium">{formData.employeeCount} employees</div>
          
          <div>Revenue:</div>
          <div class="font-medium">{formData.annualRevenue}</div>
        </div>
      </div>
      
      <div>
        <h4 class="font-medium mb-2">Risk Score</h4>
        {#if true}
          {@const score = calculateRiskScore()}
          <div class="flex items-center space-x-4">
            <div 
              class={`text-lg font-bold px-3 py-1 rounded-lg ${
                score >= 75 ? 'bg-red-100 text-red-800' : 
                score >= 50 ? 'bg-yellow-100 text-yellow-800' : 
                'bg-green-100 text-green-800'
              }`}
            >
              {score}/100
            </div>
            <div class="text-sm text-gray-600">
              {#if score >= 75}
                High Risk
              {:else if score >= 50}
                Medium Risk
              {:else}
                Low Risk
              {/if}
            </div>
          </div>
          
          <div class="w-full bg-gray-200 rounded-full h-2.5 mt-2">
            <div 
              class={`h-2.5 rounded-full ${
                score >= 75 ? 'bg-red-500' : 
                score >= 50 ? 'bg-yellow-500' : 
                'bg-green-500'
              }`} 
              style="width: {score}%"
            ></div>
          </div>
        {/if}
      </div>
      
      <div>
        <h4 class="font-medium mb-2">Key Risk Factors</h4>
        <ul class="list-disc pl-5 space-y-1 text-sm">
          {#if formData.dataTypes.includes('pii') || formData.dataTypes.includes('health') || formData.dataTypes.includes('payment')}
            <li>Handling of sensitive data increases your data breach risk exposure</li>
          {/if}
          
          {#if formData.industry === 'Finance/Banking' || formData.industry === 'Healthcare'}
            <li>Your industry faces heightened regulatory requirements and targeted attacks</li>
          {/if}
          
          {#if !formData.securityMeasures.includes('mfa')}
            <li>Lack of multi-factor authentication significantly increases unauthorized access risk</li>
          {/if}
          
          {#if !formData.securityMeasures.includes('backups')}
            <li>Without proper backups, your ransomware risk is substantially higher</li>
          {/if}
          
          {#if formData.incidentHistory === 'Yes'}
            <li>Previous security incidents indicate potential vulnerabilities in your security posture</li>
          {/if}
        </ul>
      </div>
      
      <div>
        <h4 class="font-medium mb-2">Next Steps</h4>
        <p class="text-sm text-gray-700 mb-4">Based on your risk profile, we recommend the following actions:</p>
        <ul class="list-disc pl-5 space-y-1 text-sm text-gray-700">
          {#if !formData.securityMeasures.includes('mfa')}
            <li>Implement multi-factor authentication across all critical systems</li>
          {/if}
          
          {#if !formData.securityMeasures.includes('training')}
            <li>Establish regular security awareness training for all employees</li>
          {/if}
          
          {#if !formData.securityMeasures.includes('backups')}
            <li>Set up secure, offsite backup systems to mitigate ransomware risk</li>
          {/if}
          
          {#if !formData.securityMeasures.includes('incident')}
            <li>Develop a formal incident response plan</li>
          {/if}
          
          <li>Consider a cyber insurance policy with coverage for your specific risk profile</li>
        </ul>
      </div>
      
      <div class="pt-4">
        <button 
          on:click={() => isSubmitted = false}
          class="w-full py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
        >
          Start Over
        </button>
      </div>
    </div>
  {/if}
</div>