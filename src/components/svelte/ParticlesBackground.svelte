<!--
  ParticlesBackground.svelte
  
  This component creates an interactive particle animation using tsParticles v3.
  
  FEATURES:
  - Creates animated, interactive particles with connections between them
  - Responds to mouse hover and click interactions
  - Can be used as an absolute-positioned background or as a contained element
  
  USAGE:
  ```
  <ParticlesBackground id="my-particles" isAbsolute={true} client:only="svelte" />
  ```
  
  PROPS:
  - id: string - Unique identifier for the tsParticles container (default: "tsparticles")
  - isAbsolute: boolean - Whether to position the container absolutely (covers entire parent)
                          or as a relative element (default: true)
  
  IMPLEMENTATION DETAILS:
  - Uses tsParticles v3 (@tsparticles/engine and @tsparticles/slim)
  - Initializes after component mount with a delay to ensure DOM is ready
  - Provides proper cleanup on component unmount
  - Uses Svelte's bind:this to directly access the container element
  
  CONFIGURATION:
  The particle behavior is configured in the tsParticles.load() method. Main options include:
  - particles.number.value - Number of particles to display
  - particles.color.value - Color of particles (hex format)
  - particles.size.value - Size of particles in pixels
  - particles.links - Settings for connections between particles
  - particles.move - Movement behavior settings
  - interactivity - Mouse interaction settings
  
  To modify the particle appearance or behavior, adjust the options object
  passed to tsParticles.load().
  
  Last updated: May 3, 2025
-->

<script>
  import { onMount } from 'svelte';

  export let id = "tsparticles";
  export let isAbsolute = true;
  
  let container;
  
  onMount(() => {
    console.log("ParticlesBackground mounted with ID:", id);
    
    // Initialize after a delay to ensure DOM is ready
    setTimeout(async () => {
      try {
        console.log("Starting particles initialization");
        
        // Import the required libraries
        const { tsParticles } = await import("@tsparticles/engine");
        const { loadSlim } = await import("@tsparticles/slim");
        
        console.log("Libraries imported successfully");
        
        // Initialize the tsParticles engine
        await loadSlim(tsParticles);
        console.log("Slim preset loaded");
        
        // Check if the DOM element exists
        if (!container) {
          console.error("Container ref not found!");
          return;
        }
        
        console.log("Container found:", container);
        
        // Load particles with a simple configuration
        await tsParticles.load({
          id: id,
          element: container,
          options: {
            fullScreen: false,
            fpsLimit: 60,
            particles: {
              color: {
                value: "#0284c7"  // Tailwind blue-600
              },
              number: {
                value: 80         // Particle density
              },
              shape: {
                type: "circle"    // Particle shape (can be "circle", "square", etc.)
              },
              opacity: {
                value: 0.8        // Particle opacity (0-1)
              },
              size: {
                value: 3          // Particle size in pixels
              },
              links: {
                enable: true,     // Enable links between particles
                color: "#64748b", // Tailwind slate-500
                distance: 150,    // Maximum distance for links to form
                opacity: 0.5,     // Opacity of links
                width: 1          // Width of links in pixels
              },
              move: {
                enable: true,     // Enable particle movement
                speed: 2,         // Speed of movement
                direction: "none", // Random direction
                random: false,    // Random movement
                straight: false,  // Straight lines or not
                outMode: "out",   // Behavior when reaching the edge
                bounce: false,    // Bounce off edges
                attract: {        // Attraction behavior
                  enable: false,
                  rotateX: 600,
                  rotateY: 1200
                }
              }
            },
            interactivity: {
              detectsOn: "canvas",
              events: {
                onHover: {
                  enable: true,   // Enable hover interaction
                  mode: "grab"    // Action on hover (grab, bubble, repulse)
                },
                onClick: {
                  enable: true,   // Enable click interaction
                  mode: "push"    // Action on click (push, remove, bubble)
                },
                resize: true      // Resize particles when window resizes
              },
              modes: {
                grab: {
                  distance: 140,  // Hover grab radius
                  links: {
                    opacity: 1    // Link opacity when grabbed
                  }
                },
                push: {
                  quantity: 4     // Number of particles to add on click
                }
              }
            }
          }
        }).then((container) => {
          console.log("Particles loaded successfully:", container);
          
          // Manually check if a canvas was created
          setTimeout(() => {
            const canvas = document.querySelector(`#${id} canvas`);
            console.log("Canvas check after load:", canvas);
          }, 500);
        });
      } catch (error) {
        console.error("Error initializing particles:", error);
      }
    }, 500);
    
    return () => {
      // Cleanup on component unmount
      try {
        const { tsParticles } = import("@tsparticles/engine");
        tsParticles.destroy(id);
      } catch (e) {
        console.error("Error cleaning up particles:", e);
      }
    };
  });
</script>

<!-- Bind the element reference to access it in the script -->
<div bind:this={container} id={id} class={isAbsolute ? "particles-container-absolute" : "particles-container-relative"}>
  <!-- Canvas will be created here by tsParticles -->
</div>

<style>
  .particles-container-absolute {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    width: 100%;
    height: 100%;
    z-index: 0;
  }
  
  .particles-container-relative {
    position: relative;
    width: 100%;
    height: 100%;
    min-height: 300px;
  }
</style>