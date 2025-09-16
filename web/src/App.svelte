<script lang="ts">
	import { useNuiEvent } from "$lib/utils/useNuiEvent";
	import PopUp from "./roots/popUp.svelte";
    import { visible } from "./store";
    let isVisible:boolean = $state(false);
    visible.subscribe((value) => {
        isVisible = value;
    })
    useNuiEvent('closePopUp',(data:boolean) =>{
        visible.set(data);
    })
    useNuiEvent('openPopUp',(data:boolean) => {
        visible.set(data);   
    })
</script>
<style>
    main{
        width: 100%;
        height: 100%;
    }
</style>
<main>
    {#if isVisible}
        <PopUp />
    {/if}
</main>