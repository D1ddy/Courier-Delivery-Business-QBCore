<script lang="ts">
	import { useNuiEvent } from "$lib/utils/useNuiEvent";
    let popUpText:string = $state(' ');
    useNuiEvent('playerIsDeliveryDriver:notification',(data:string) => {
        popUpText = data;
    })
    useNuiEvent('playerIsNotDeliveryDriver:notification',(data:string) => {
        popUpText = data;
    })
</script>
<style>
    h1{
        color: red;
    }
</style>
<h1>
   {popUpText} 
</h1>
