import prisma from "~/lib/prisma";
import {Product} from "@prisma/client";

export default defineEventHandler(async (event) => {
    const query = getQuery(event);

    let categories;
    if (!query.search){
        categories = await prisma.category.findMany({
            select: {
                name: true,
                products: true,
            },
        });
    } else {
        const searchString = query.search as string;

        categories = await prisma.category.findMany({
            where: {
                products: {
                    some: {
                        OR: [
                            { name: { contains: searchString} },
                            { description: { contains: searchString} }
                        ],
                    },
                },
            },
            select: {
                name: true,
                products: {
                    where: {
                        OR: [
                            { name: { contains: searchString} },
                            { description: { contains: searchString} }
                        ],
                    },
                    select: {
                        id: true,
                        name: true,
                        description: true
                    }
                }
            },
        });
    }

    if (!event.context.user){
        return categories;
    }

    const currInterestingProducts = await prisma.interestedProduct.findMany({
        where: {
            Organization: {
                User: {
                    id: event.context.user.id
                }
            }
        }, select: {
            Product: true
        }
    })

    console.log(currInterestingProducts.length);

    // Calculate the interest percentage for each category
    const sortedCategories = categories?.map(category => {
            const totalProducts = category.products.length;
            const interestedProducts = category.products.filter(product => currInterestingProducts.find((e)=>(e.Product.id == product.id)) !== undefined)
                .sort((a, b) => {
                    return a.name.localeCompare(b.name);
                });

            console.log(interestedProducts);
            const otherProducts = category. products.filter(product => currInterestingProducts.find((e)=>(e.Product.id == product.id)) === undefined)
                .sort((a, b) => {
                    return a.name.localeCompare(b.name);
                });

        const interestPercentage = totalProducts > 0 ? (interestedProducts.length / totalProducts) * 100 : 0;

            return {
                name: category.name,
                totalProducts,
                interestPercentage,
                products: [...interestedProducts, ...otherProducts]
            };
        }).sort((a, b) => b.interestPercentage - a.interestPercentage);

    return sortedCategories;
})

function compareProducts(a: Product, b: Product, interestedProducts: Product[]) {
    if (interestedProducts == undefined) {
        return a.name.localeCompare(b.name)
    }
    const hasA = interestedProducts.find(e => e.id == a.id) != undefined
    const hasB = interestedProducts.find(e => e.id == b.id) != undefined

    if (hasA && hasB) {
        console.log("has both")
        return a.name.localeCompare(b.name)
    }
    else if (hasB) {
        return -1;
    }
    else if (hasA) {
        return 1;
    }
    return a.name.localeCompare(b.name)
}