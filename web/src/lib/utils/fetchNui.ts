import { isEnvBrowser } from "$lib/utils/misc";

/**
 * @param eventName - The endpoint eventname to target
 * @param data - Data you wish to send in the NUI Callback
 * @param browserData - Data you wish to return when in browser
 * 
 * @return returnData - A promise for the data sent back by the NuiCallbacks CB argument
 */
export async function fetchNui<T = any>(
	eventName: string,
	data: unknown = {},
	browserData?: T
): Promise<T> {
	if (isEnvBrowser()) return await new Response(JSON.stringify(browserData)).json();

	const options = {
		method: "post",
		headers: {
			"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify(data),
	};

	const resourceName = (window as any).GetParentResourceName
		? (window as any).GetParentResourceName()
		: "nui-frame-app";

	const resp = await fetch(`https://${resourceName}/${eventName}`, options);
	return await resp.json();
}
